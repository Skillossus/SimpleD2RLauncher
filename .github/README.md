![AccountPicker](assets/demo.png?raw=true "AccountPicker")

---

**Introduction:**

Hey, everyone! Today, I'm excited to share a quick and convenient way to launch and automatically log into multiple instances of Diablo 2: Resurrected from any region. The best part? No need for complicated shortcuts, and it all happens within a single installation folder.

I developed this script because existing launchers were too feature-rich for my modest three accounts. I simply wanted an easy way to chase after Dclone and simplify my cross-region trading experience on platforms like Traderie. As someone who values security, I was hesitant to run PowerShell scripts I couldn't easily read through. So, I created a solution in under 100 lines of clean, digestible, and maintainable code.

Now, let's dive into setting it up.

---

**Prerequisites:**

Before we begin, make sure you meet these two prerequisites:

1. **Battle.net Accounts:** You'll need a Battle.net account with a D2R license for each copy of D2 you plan to run. If you want to run two clients simultaneously, you'll need two different Battle.net accounts, each with a purchased copy of D2R.

2. **Sysinternals Handle Program:** Unfortunately, I couldn't make this script entirely self-contained. Download the handle program from Microsoft. We'll place `handle.exe` in the same directory later.

---

**Setup:**

1. **Download SimpleD2RLauncher:**
   - Visit my GitHub repository and download the latest release. https://github.com/Skillossus/SimpleD2RLauncher/releases/latest
   - You can place the `SimpleD2RLauncher.ps1` file anywhere. For convenience, I'm placing it on my desktop in a folder called "SimpleD2RLauncher."

2. **Get the Handle Program from Microsoft:**
   - Download `handle.exe` from Microsoft. https://learn.microsoft.com/en-us/sysinternals/downloads/handle
   - Extract it to the same directory as `SimpleD2RLauncher.ps1`

---

**Setting Up Accounts:**

Now, let's set up the accounts you want to launch. This script utilizes a web token, the exact same method Battle.net uses to launch the game. You must repeat these steps for each account you wish to set up.
1. In a private browser (CTRL + SHIFT + N) go to https://us.battle.net/login/en/?externalChallenge=login&app=OSI and log in. This will redirect you to a page such as http://localhost:0/?ST=US-53e84b256e5549ee8dceb3540b15b250-1234567 and present you with an error. This is intended.
2. You will see an error page that states `The webpage at http://localhost:0/?ST=US-53e84b256e5549ee8dceb3540b15b250-1234567 might be temporarily down or it may have moved permanently to a new web address.`. Good. We are specifically interested in `US-53e84b256e5549ee8dceb3540b15b250-1234567` as this will be our web token for this account. Copy this token and **NEVER GIVE IT TO ANYONE** because anyone with this web token will have full access to your account.
3. Open `SimpleD2RLauncher.ps1` in your favorite text editor and modify `$DISPLAY_NAMES` to a descriptive name that works for you (does **NOT** need to be your email). For example `$DISPLAY_NAMES = @("Hammerdin")`
4. Modify `$WEB_TOKENS` to contain the web token you just copied from Step 2 in our case the new value would be `$WEB_TOKENS = @("US-53e84b256e5549ee8dceb3540b15b250-1234567")`
5. Close out of this private browser completely. You need to do this so that you can make a new private window and log in with your second (and third+) accounts. If, when navigating back to https://us.battle.net/login/en/?externalChallenge=login&app=OSI you are NOT presented with a username and password prompt. Then close the private browser and try again.
6. Repeat this process for each account. Separating each display name and web token with a comma and ensuring they are wrapped in double quotes. For example, for 2 accounts your script should look like this (substituting your own values).
   - `$DISPLAY_NAMES = @("Hammerdin", "BO Barb")`
   - `$WEB_TOKENS = @("US-REDACTED-1234567", "US-REDACTED-7654321")`

---

**Launching the Game:**
1. Right-click on `SimpleD2RLauncher.ps1` and run it in PowerShell. If a UAC prompt appears, approve it.
2. You'll now be presented with all of your accounts.
   - To launch ALL of your accounts, just press enter.
   - To launch multiple accounts, type in the corresponding number for each account separated by a space. Eg: 1 3 4
   - To launch a single account type in the number for the account you wish to launch followed by enter.
3. Choose your region.
   - To launch in the default region defined in the `$DEFAULT_REGION`, just press enter.
   - To launch in a different region, type in 1 for Americas, 2 for Europe, or 3 for Asia followed by enter.
4. Once you've hit the character select screen, come back to the powershell window, and press enter to launch the next account. Returning to this powershell window each time you're ready to launch the next account.

---

**Work in Progress:**
A set-up video. Coming soon.
