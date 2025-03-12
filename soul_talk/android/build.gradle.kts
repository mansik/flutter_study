allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// 1. comment this block
//subprojects {
//    project.evaluationDependsOn(":app")
//}

// 2. add this block
subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            extensions.findByType<com.android.build.gradle.LibraryExtension>()?.run {
                if (namespace == null || namespace!!.isEmpty()) {
                    namespace = project.group.toString()
                }
            }
        }
    }

    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
