
# Steambox

Steam (© Valve Corporation) 게임을 Windows Sandbox 안에서 추가설치 없이 실행할 수 있는 도구입니다.




## 조건

- 운영체제가 Windows 11 22H2 이상이여야 합니다.
- Windows 버전이 Pro, Enterprise, Pro Education/SE, Education 중 하나여야 합니다.
- 최소 8GB RAM이 장착되어 있어야 합니다.
- 1GB 이상의 사용 가능한 디스크 공간 (SSD 권장)이 있어야 합니다.
- 두 개 이상의 CPU 코어(하이퍼 스레딩이 권장되는 4개 코어)가 있어야 합니다.



## Windows Sandbox 기능 활성화

Windows Powershell을 관리자 권한으로 실행한 후 아래 명령어를 실행합니다.

```powershell
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
```
작업이 완료되었다면, 컴퓨터를 재부팅합니다.



##  Steam 설치하기

https://store.steampowered.com/about/  


위 페이지에서 Windows용 Steam을 다운로드합니다.

**이때, Steam 설치 폴더를 기본으로 선택합니다 (변경 X)**

## Steambox 실행하기

1.먼저 github에서 steambox 레포를 내려받습니다.  
2.컴퓨터에 C 드라이브에 ``SandboxShare`` 폴더를 생성합니다.  
3.내려받은 steambox 레포(폴더)를 ``SandboxShare`` 폴더에 복사(또는 이동)합니다.
4.``C:\SandboxShare\steambox`` 경로에 진입하고, ``Sandbox.wsb``를 클릭해 실행합니다.
5.Windows Sandbox가 실행되고, 바탕화면에 이미 설치되어 있는 게임과 Steam 런처 바로가기가 표시됩니다.

아래는 Goose Goose Duck, Euro Truck Simulator 2 Demo가 설치되어 있는 환경에서 Sandbox를 실행한 사진입니다.
![image](https://github.com/agliogambas/steambox/assets/67851900/e4bd89c6-54f1-43b4-a3de-bfd2b534b291)  
(게임 바로가기가 생성되는 게임의 기준은, Windows Sandbox를 설치한 PC에 Steam 런처로 설치한 게임입니다.)
