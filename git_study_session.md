# 📚 Git 마스터 가이드 (심화 & 트러블슈팅)

**기본적인 동기화부터 고급 역사 조작까지**, 실무에서 필요한 모든 Git 명령어를 시나리오별로 정리했습니다.

---

## 0. 시작하기: 원격 저장소 동기화 (Remote Sync)

협업의 기초가 되는 원격 저장소(`origin`)와의 통신 방법입니다.

### 📡 Git Fetch vs Pull
두 명령어의 결정적 차이는 **"병합(Merge)을 하느냐 마느냐"**입니다.

1. **`git fetch`**: 원격 저장소의 최신 이력을 **가져오기만** 합니다. (내 코드는 절대 건드리지 않음)
   - 용도: 남들이 뭘 했는지 구경만 하고 싶을 때.
2. **`git pull`**: `fetch` + `merge`를 한 번에 수행합니다.
   - 용도: 최신 코드를 내 코드에 합쳐서 업데이트하고 싶을 때.
   - **꿀팁 (`--rebase`)**: `git pull --rebase`를 쓰면 불필요한 Merge Commit 없이 깔끔하게 가져올 수 있습니다.

### 🚀 Git Push (보내기)
- **`git push -u origin main`**: 처음 보낼 때 `-u`(`--set-upstream`)를 쓰면, 다음부턴 `git push`만 입력해도 됩니다.
- **`git push --force-with-lease`**: 강제 푸시가 필요할 때, 남의 코드를 덮어쓰지 않는 안전한 옵션입니다.

---

## 1. Git 역사 관리: Merge vs Rebase vs Reset

### 🔀 Merge (병합)
두 브랜치를 **"있는 그대로 합치는"** 방법입니다.
- **주요 옵션**: `--no-ff` (히스토리 보존), `--squash` (커밋 뭉치기)
- **`-X` 전략**: `git merge -X theirs` (충돌 시 남의 것 우선), `-X ours` (내 것 우선)

#### 🎬 실전 시나리오: "기능 개발 완료 후 합치기"
```bash
git checkout main
git merge --no-ff feature/login
```

### 🧹 Rebase (재배치)
내 브랜치를 최신 `main` 뒤로 **"옮겨 심는"** 방법입니다.
- **주요 옵션**: `--interactive` (`-i`)

#### 🎬 실전 시나리오: "내 브랜치 최신화 & 커밋 정리"
```bash
git checkout my-branch
git rebase -i main
# (편집기에서 pick -> squash로 자잘한 커밋 정리)
```

### ⏪ Reset (되돌리기)
시간을 거슬러 **"특정 시점으로 되돌아가는"** 방법입니다.
- **`--soft`**: 커밋 취소, 파일은 Staged (수정 후 재커밋용)
- **`--mixed`**: 커밋 취소, 파일은 Unstaged (기본값)
- **`--hard`**: 커밋 취소, 파일 삭제 (완전 복구)

#### 🎬 실전 시나리오: "방금 커밋 취소하고 싶어요"
```bash
git reset --soft HEAD~1
```

---

## 2. 임시 저장: Git Stash (`stash`) 심화

하던 작업을 커밋하지 않고 **"잠시 서랍에 넣어두는"** 기능입니다.
- **주요 옵션**: `--include-untracked` (`-u`)

#### 🎬 실전 시나리오: "긴급 버그 수정해주세요! 🚨"
```bash
git stash push -u -m "로그인 기능 개발 중 임시 저장"
git checkout hotfix
# (작업 후 복귀)
git checkout feature/login
git stash pop
```

### 🌿 Stash Branch
스태시 복구 시 충돌이 날 때, 아예 새 브랜치로 격리해서 꺼내는 방법입니다.
```bash
git stash branch new-feature stash@{0}
```

---

## 3. 상태 확인의 끝판왕: Status & Diff

### 📊 Git Status
- `git status -s`: 파일 상태를 짧고 굵게 요약해 줍니다.
  - `M` (Modified), `A` (Added), `??` (Untracked)

### 🔍 Git Diff
- `git diff`: 아직 `add` 하지 않은 변경분 보기.
- `git diff --cached`: `add`는 했지만 아직 `commit` 안 한 내용 보기.
- `git diff HEAD`: 전체 변경분 보기.

---

## 4. 커밋 수정 & 네비게이션

### 🛠 Commit Amend (`--amend`)
가장 최근 커밋을 수정합니다.
```bash
git add missed-file.txt
git commit --amend --no-edit  # 방금 커밋에 파일 끼워넣기
```

### 📍 상대 참조 (HEAD)
- `HEAD^`: 1단계 상위 (부모)
- `HEAD~2`: 2단계 상위

---

## 5. 파일 청소: Git Clean (`clean`)

Tracked 되지 않은(Untracked) 파일들을 **"한 방에 청소"**합니다.

#### 🎬 실전 시나리오: "빌드 에러나서 초기화하고 싶어요"
```bash
git clean -n -d -X  # 지워질 파일 미리 보기 (Ignored 파일만)
git clean -f -d -X  # 실제 삭제
```

---

## 6. 범인 찾기 및 수정: Blame & Filter-Branch

### 🕵️‍♂️ Git Blame
한 줄 한 줄 누가 짰는지 검사합니다.
```bash
git blame -L 10,20 config.js  # 10~20줄만 확인
```

### ✂️ Git Filter-Branch ("역사 대수술")
파일을 역사 속에서 완전히 삭제합니다.
```bash
git filter-branch -f --tree-filter 'rm -f secrets.json' HEAD
git push --force origin main
```

---

## 7. 쪼개서 담기: Git Add Patch (`add -p`)

파일의 일부분만 선택해서 커밋합니다.
- `y` (담기), `n` (패스), `e` (직접 수정)

**꿀팁**: 새 파일(`Untracked`)은 `git add -N 파일명`을 먼저 해야 패치가 가능합니다.

---

## 8. 기타 유용한 기능 (Bonus)

### 🍒 Cherry-Pick
다른 브랜치의 **특정 커밋 하나만** 가져옵니다.
```bash
git cherry-pick [커밋ID]
```

### 🛟 Reflog (구명조끼)
`reset --hard`로 지워진 커밋도 복구할 수 있는 기록 보관소입니다.
```bash
git reflog
git reset --hard HEAD@{5}
```

### 🏷️ Git Tag (버전 달기)
특정 커밋에 보기 쉬운 **버전 이름표**를 붙입니다.
```bash
git tag v1.0.0             # 태그 생성
git push origin v1.0.0     # 태그 푸시
```

### ⌨️ Git Alias (단축키 설정)
긴 명령어를 짧게 줄여 쓰는 꿀팁입니다.
```bash
# git st -> git status
git config --global alias.st status

# git lg -> 예쁜 로그 보기 (강추 ⭐)
git config --global alias.lg "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"

# 💡 내 Alias 목록 확인하기
# 💡 내 Alias 목록 확인하기
git config --global --get-regexp alias
```

---

## 9. 실무 Git 용어 & 약어 사전 (Glossary)

개발자들끼리 대화할 때 자주 쓰는 용어들입니다.

### ⏩ FF (Fast-Forward)
"빨리 감기"라는 뜻입니다.
- **상황**: `main` 브랜치에서 분기한 내 브랜치를 다시 합치려는데, 그사이에 `main`에 아무런 변화가 없을 때.
- **동작**: 굳이 "Merge Commit"을 만들지 않고, `main`의 머리(HEAD)만 내 브랜치 끝으로 쓱 이동시킵니다.
- **특징**: 역사가 일직선으로 깔끔하지만, "언제 병합했는지" 기록이 안 남습니다. (그래서 보통 `--no-ff` 옵션으로 끕니다.)

### 📥 PR (Pull Request) / MR (Merge Request)
"내 코드를 당겨가세요(Pull)!"라는 요청입니다.
- **의미**: "내가 `feature` 브랜치에서 작업 다 했으니, `main` 브랜치에 합쳐주세요."라고 팀원들에게 검사(Code Review)를 요청하는 행위입니다.
- **PR**: GitHub, Bitbucket에서 쓰는 말.
- **MR**: GitLab에서 쓰는 말. (같은 뜻입니다)

### 🚧 WIP (Work In Progress)
"작업 중"이라는 뜻입니다.
- **용도**: 아직 미완성이지만, 코드 백업이나 중간 피드백을 위해 PR을 올릴 때 제목 앞에 붙입니다. 예: `[WIP] 로그인 페이지 디자인`

### 👍 LGTM (Looks Good To Me)
"제 눈엔 좋아 보이네요" (승인)
- **용도**: 코드 리뷰 후 "합격! 병합해도 좋습니다."라는 뜻으로 댓글에 남기는 약어입니다.

### 🐛 Issue (이슈)
버그나 새로운 기능 요청 등 "해결해야 할 일감"을 뜻합니다.
- PR을 보낼 때 `Closes #123`라고 적으면, 병합될 때 123번 이슈가 자동으로 닫힙니다.

