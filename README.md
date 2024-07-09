<!-- markdownlint-configure-file {
  "MD013": {
    "code_blocks": false,
    "tables": false
  },
  "MD033": false,
  "MD041": false
} -->

<div align="center">

<h1 align="center">
  <b>Nimbus</b>
</h1>

<p align="center">
  <i align="center">Pixar's universal scene description running in <b>swift on server</b>.</i>
</p>

</div>

<h4 align="center">
  <a href="https://wabiverse.github.io/SwiftUSD/documentation/pixarusd/">
    <img src="https://img.shields.io/badge/v23%2E11%2E39-DocumentationSource?style=flat-square&label=docs&labelColor=F05138&logo=swift&color=gray&logoColor=white">
  </a>
  <a href="https://github.com/wabiverse/SwiftUSD/actions/workflows/swift-ubuntu.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/wabiverse/SwiftUSD/swift-ubuntu.yml?style=flat-square&label=ubuntu%20&labelColor=E95420&logoColor=FFFFFF&logo=ubuntu">
  </a>
  <a href="https://github.com/wabiverse/SwiftUSD/actions/workflows/swift-macos.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/wabiverse/SwiftUSD/swift-macos.yml?style=flat-square&label=macOS&labelColor=000000&logo=apple">
  </a>
  <a href="https://github.com/wabiverse/SwiftUSD/graphs/contributors">
    <img src="https://img.shields.io/github/contributors-anon/wabiverse/SwiftUSD?color=8A2BE2&style=flat-square" alt="contributors" style="height: 20px;">
  </a>
  <br>
  <a href="https://discord.gg/bfW4NyKpuA">
    <img src="https://img.shields.io/badge/discord-7289da.svg?style=flat-square&logo=discord" alt="discord" style="height: 20px;">
  </a>
  <a href="https://wabi.foundation">
    <img src="https://img.shields.io/badge/wabi_foundation-black?style=flat-square&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1MDAgNTAwIj4KICA8ZGVmcz4KICAgIDxzdHlsZT4KICAgICAgLmNscy0xIHsKICAgICAgICBmaWxsOiAjNDM0MzQzOwogICAgICB9CgogICAgICAuY2xzLTEsIC5jbHMtMiB7CiAgICAgICAgc3Ryb2tlLXdpZHRoOiAwcHg7CiAgICAgIH0KCiAgICAgIC5jbHMtMiB7CiAgICAgICAgZmlsbDogI2ZmZjsKICAgICAgfQogICAgPC9zdHlsZT4KICA8L2RlZnM+CiAgPHBhdGggY2xhc3M9ImNscy0yIiBkPSJNMTMyLjQyLDMzOS42NXMtMzQuOS0yOC40OC00NS41Ny05OC42MmMtMy4xMy0yNy4yNS4xMS01My42NywxMC4xNS03OS4yMiwxMS40OS0yOS4yNSwyOS44OC01My4xOCw1NC45OS03Mi4wMyw0Ljk5LTMuNzQsMTAuNDUtNi44OCwxNC42LTExLjc1LDYuMDEtNy4wNiw3LjkxLTE1LjE0LDYuNzctMjQuMTUtLjg3LTYuNzUtMy4zNC0xMy01LjkzLTE5LjItMS42LTMuODUtMy4zNy03LjY2LTMuODktMTEuODgtLjk5LTcuODgsMy4yOS0xNC43NiwxMC43Mi0xNy42NSw3Ljg0LTMuMDcsMTUuODMtMi45NywyMy45Mi0xLjY1LDEyLjYsMi4wOCwyNC43Miw1LjkzLDM2LjY2LDEwLjM3LDIxLjg3LDguMTMsNDIuNjQsMTguNSw2Mi40MiwzMC44NiwyMi45OSwxNC4zNSw0NC4wNiwzMS4wOCw2Mi41Niw1MC45NiwxMy4zNywxNC4zOCwyNS4wOCwyOS45NiwzNC4zOCw0Ny4yNSwxOC4xMSwzMy42NywyNC4wMyw2OS40MiwxNy41OCwxMDcuMTctMi4yNSwxMy4yLTYuMTgsMjUuNzQtMTIuOTgsMzcuMzctMTIuMjMsMjAuODgtMzAuNDYsMzEuMTctNTQuNTUsMzEuNS0xMy4xNC4xNy0yNS41MS0zLjA0LTM3LjQ4LTguMDktMTEuMy00Ljc1LTIyLjA2LTEwLjQ2LTMyLjU3LTE2LjY2LTExLjY5LTYuODktOTguMzQtNjkuNzgtMTIwLjM0LTc0LjYxLTE3Ljk0LDMuMTYtMzMuNTYsNy45Ni00MS4xMSwyNC43LTM0LjU1LDMzLjg2LDE5LjcyLDk1LjM1LDE5LjcyLDk1LjM1aC0uMDNaTTMxMS42NSwyNTYuNjhjLjAzLTguMi05Ljc3LTE2LjE5LTE4LjE5LTE0Ljg0LTYuNTYsMS4wNS05Ljg1LDYuNjctNy41OCwxMi45MywyLjI3LDYuMjksOC43OCwxMC45NywxNS40NSwxMS4wOSw1LjkyLjEzLDEwLjI5LTMuNzksMTAuMzItOS4ydi4wMloiLz4KICA8cGF0aCBjbGFzcz0iY2xzLTIiIGQ9Ik0yOTguNCwzMzMuODZjMi43MS0xLjQ4LTczLjksODYuMTgtMTY2LjIsNS45LTIyLjk2LTE5Ljk3LTY3LjU2LTEyMC42Nyw1LjI0LTEyMi43MSw0Ni4yNy0xLjI5LDExOC4xMyw2NC42OCwxMTguMTMsNjQuNjgtMjguOTItMTkuNTQtODcuMDctNTkuMjktMTIyLjE1LTI3Ljk0LTQ3LjcyLDQyLjY2LDI0LjM2LDE1Ni4zNSwxNjQuOTcsODAuMDdoMFoiLz4KICA8cGF0aCBjbGFzcz0iY2xzLTIiIGQ9Ik0yMzIuNzEsMzU3LjljMTAuNy0zLjA3LDIwLjYzLTguMDQsMzAuODEtMTIuMzcsMTAuNy00LjU1LDIxLjQzLTkuMDMsMzIuOS0xMS4zOCw3LjExLTEuNDUsMTQuODgtMS40MiwxOS44Ny4xMS01LjYzLDguMTUtMTAuMjcsMTYuODItMTUuNTUsMjUuMTMtMi4xNCwzLjM4LTQuNTUsNi42MS03LjMsOS41Mi0xMS45MywxMi41Ny0yNi40NywxNy44My00Mi43NywxOC4wNi00LjE0LjA2LTguMjksMC0xMy4yLDAsNy4yOSwxLjUzLDEzLjc1LDMuMTMsMjAuMDYsNS40OSwxNS45MSw1Ljk2LDI1LjI3LDE3LjU2LDI5LjExLDMzLjc1LDQuMTksMTcuNjcsNi44NCwzNS42OSwxMS40NCw1My4yOSwxLjQyLDUuNDQsMi42NiwxMC45NSw0LjYxLDE2LjI0LjQ3LDEuMjYuNTIsMS44MS0xLjE2LDEuNTktMTcuNTktMi40MS0zNC42LTYuNjEtNTAuMTUtMTUuNTYtMTMuOTItOC4wMi0yNC43NS0xOS4xNi0zMy4yOC0zMi43LTcuOTYtMTIuNjUtMTMuNTgtMjYuNDctMTkuNy00MC4wMy0zLjIxLTcuMTEtNS4zMi0xMi45LTkuNDYtMTkuMTYtNC41My02LjgzLTEwLjU5LTEyLjUxLTE3LjUtMTYuOTMtMjguMzctMTguMTctNDQuNjUtMzguODgtNDUuMDgtMzkuMzQsMCwwLDI5LjU4LDM1LjczLDg0LjksMzAuMyw3LjMtMS40NSwxNC41NS0zLjA0LDIxLjQxLTYuMDFsLjAyLS4wMloiLz4KICA8cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0zMTEuNjMsMjU2LjY4Yy0uMDIsNS40MS00LjQxLDkuMzEtMTAuMzIsOS4yLTYuNjctLjE0LTEzLjE5LTQuODEtMTUuNDUtMTEuMDktMi4yNy02LjI4LDEuMDItMTEuODgsNy41OC0xMi45Myw4LjQyLTEuMzUsMTguMjIsNi42NCwxOC4xOSwxNC44NHYtLjAyWiIvPgo8L3N2Zz4=" alt="wabi foundation" style="height: 20px;">
  </a>
  <a href="https://openusd.org/release/index.html">
    <img src="https://img.shields.io/badge/openusd-blue.svg?style=flat-square&logo=data:image/svg%2bxml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAxMiAxMiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTYuOTQwMzEgMTEuMzU4MlY3LjQ3NzY0VjMuNjU2NzRMMCAxLjI2ODY4VjguOTg1MUw2Ljk0MDMxIDExLjM1ODJaTTEuMjY4NjYgOC4wMTQ5NVYzLjE3OTEzTDUuNjExOTUgNC42NTY3NFY5LjQ5MjU3TDEuMjY4NjYgOC4wMTQ5NVoiIGZpbGw9IiMyMDhFQ0QiLz4KPHBhdGggZD0iTTEuNzc2MTIgNy41OTcwM0w1LjA4OTU2IDguNzMxMzZWNS4wNzQ2NEwxLjc3NjEyIDMuOTQwMzFWNy41OTcwM1oiIGZpbGw9IiM3REQxRjYiLz4KPHBhdGggZD0iTTguOTI1MzQgNS41OTcwMkw5Ljk5OTk3IDUuOTcwMTZWMS4zNTgyMUw2LjA0NDc0IDBWMS4xNjQxOEw4LjkyNTM0IDIuMTY0MThWNS41OTcwMloiIGZpbGw9IiM3REQxRjYiLz4KPHBhdGggZD0iTTIuOTg1MTEgMC41OTcwMTVWMS43NjEyTDcuMzczMTcgMy4yODM1OVY4LjI1Mzc0TDguNDQ3OCA4LjYxMTk1VjIuNDc3NjFMMi45ODUxMSAwLjU5NzAxNVoiIGZpbGw9IiMzNUMzRjEiLz4KPC9zdmc+Cg==" alt="youtube" style="height: 20px;">
  </a>
</h4>

> [!IMPORTANT]
> This project is still in its early inception phase, and I am exploring many of the concepts voiced by
> community insight, if you have any recommendations or experiments of your own, please don't hesitate
> to collaborate.

<br/>

<div align="center">

# Serving the Metaverse

</div>

This Swift package provides a simple example demonstrating
Universal Scene Description (**USD**) running in [**Swift on Server**](https://www.swift.org/documentation/server) with [**Vapor**](https://vapor.codes), this project aims to serve as a cross-platform experimental sandbox to eventually be able to create collaborative networked editing of **USD** scenes, and explore what's possible.

For more details about using **USD** in Swift, checkout [**SwiftUSD**](https://github.com/wabiverse/SwiftUSD).

##### To build and run this server, enter the following in your terminal.
```swift
git clone https://github.com/wabiverse/Nimbus.git
cd Nimbus

swift run Nimbus
```

<br>

<br>

> [!NOTE]
> Swift is an open source programming language that is fully supported across **Linux** and [**Swift on Server**](https://www.swift.org/server/), the entire **Apple** family of devices: **macOS**, **visionOS**, **iOS**, **tvOS**, **watchOS**, as well as support for **Microsoft Windows**. To learn more about Swift, please visit [swift.org](https://www.swift.org).

<br>

<hr/>

###### *if you can `mmap` a **pixel**, you can `mmap` a **metaverse**.*
###### Nimbus is licensed under the terms of the Apache 2.0 License.
