# 🎓 Git 명령어 연습장 (Git Command Playground)

이 프로젝트는 Git 명령어들을 자유롭게 테스트하고 연습하기 위해 만들어진 **놀이터**입니다!  
실수로 코드를 망가뜨릴 걱정 없이, 다양한 Git 시나리오를 실험해 보세요.

---

## 🚀 시작하기

이 저장소를 로컬에 복제(clone)하거나 다운로드하여 연습을 시작하세요.


# 저장소 복제하기
git clone <이 저장소의 URL>

# 디렉토리로 이동
cd git-demo


---

## 📝 자주 쓰는 명령어 모음 (Cheat Sheet)

Git을 다룰 때 가장 빈번하게 사용하는 기본 명령어들입니다.

### 1. 상태 확인 및 변경사항 저장
- **현재 상태 확인**: 어떤 파일이 변경되었는지 확인합니다.
  git status
- **파일 스테이징(Stage)**: 커밋할 파일을 준비합니다.
  git add <파일명>       # 특정 파일만 추가
  git add .             # 변경된 모든 파일 추가
- **커밋(Commit)**: 변경사항을 기록합니다.
  git commit -m "작업 내용에 대한 메시지"

### 2. 이력 확인
- **로그 보기**: 커밋 히스토리를 확인합니다.
  git log --oneline --graph --all  # 그래프 형태로 깔끔하게 보기

### 3. 원격 저장소와 동기화
- **업로드(Push)**: 내 작업물을 원격 저장소에 올립니다.
  git push origin <브랜치명>
- **내려받기(Pull)**: 원격 저장소의 최신 내용을 가져옵니다.
  git pull origin <브랜치명>

---

## 🌿 브랜치(Branch) 연습해보기

새로운 기능을 개발하거나 실험할 때는 브랜치를 만드는 습관을 들여보세요.

# 1. 새로운 브랜치 생성 및 이동
git checkout -b feature/test-branch

# 2. 파일 수정 후 커밋
echo "새로운 변경사항" >> test.txt
git add test.txt
git commit -m "테스트 브랜치에서 작업함"

# 3. 메인 브랜치로 돌아오기
git checkout main

# 4. 병합(Merge) 하기
git merge feature/test-branch

---

## 🧪 추천 연습 시나리오

1. **충돌 만들기 (Conflict)**: 
   - `main` 브랜치와 다른 브랜치에서 **같은 파일의 같은 줄**을 수정하고 병합해 보세요.
   - 충돌이 났을 때 `git status`를 확인하고 해결해보세요.
2. **커밋 되돌리기**:
   - `git reset`이나 `git revert`를 사용하여 과거로 돌아가 보세요.
3. **Stash 사용하기**:
   - 작업 중에 급하게 다른 브랜치로 가야 할 때 `git stash`로 작업을 임시 저장해 보세요.

---

> **💡 팁**: 터미널에서 명령어가 기억나지 않을 때는 `git --help`를 입력해 보세요!
