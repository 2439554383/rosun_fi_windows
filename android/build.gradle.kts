buildscript {
    val kotlinVersion = "2.0.21"
    repositories {
        maven { url = uri("https://mirrors.tuna.tsinghua.edu.cn/google/maven/") }   // Google Maven 镜像
        maven { url = uri("https://mirrors.tuna.tsinghua.edu.cn/maven-central/") }   // Maven Central 镜像
        maven { url = uri("https://mirrors.tuna.tsinghua.edu.cn/gradle-plugin/") }
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.6.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
    }
}

allprojects {
    repositories {
        maven { url = uri("https://mirrors.tuna.tsinghua.edu.cn/google/maven/") }   // Google Maven 镜像
        maven { url = uri("https://mirrors.tuna.tsinghua.edu.cn/maven-central/") }   // Maven Central 镜像
        maven { url = uri("https://mirrors.tuna.tsinghua.edu.cn/gradle-plugin/") }
        google()
        mavenCentral()
    }
}
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
