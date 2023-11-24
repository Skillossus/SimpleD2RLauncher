**Introduction:**

Hey, everyone! Today, I'm excited to share a quick and convenient way to launch and automatically log into multiple instances of Diablo 2 Resurrected from any region. The best part? No need for complicated shortcuts, and it all happens within a single installation folder.

I developed this script because existing launchers were too feature-rich for my modest three accounts. I simply wanted an easy way to chase after Dclone and simplify my cross-region trading experience on platforms like Traderie. As someone who values security, I was hesitant to run PowerShell scripts I couldn't easily read through. So, I created a solution in just 90 lines of clean, digestible, and maintainable code.

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
   - You can place the SimpleD2RLauncher.ps1 file anywhere. For convenience, I'm placing it on my desktop in a folder called "SimpleD2RLauncher."

2. **Get the Handle Program from Microsoft:**
   - Download `handle.exe` from Microsoft.
   - Place it in the same directory as SimpleD2RLauncher.

---

**Setting Up Accounts:**

Now, let's set up the accounts you want to launch. This script utilizes a web token, the exact same method Battle.net uses to launch the game. You must repeat these steps for each account you wish to set up.
1. In a private browser (CTRL + SHIFT + N) go to https://us.battle.net/login/en/?externalChallenge=login&app=OSI and log in. This will redirect you to a page such as http://localhost:0/?ST=US-53e84b256e5549ee8dceb3540b15b250-1234567 and present you with an error. This is intended.
2. You will see an error page the states `The webpage at http://localhost:0/?ST=US-53e84b256e5549ee8dceb3540b15b250-1234567 might be temporarily down or it may have moved permanently to a new web address.` this is intended. We are specifically interested in `US-53e84b256e5549ee8dceb3540b15b250-1234567` as this will be our web token for this account. Copy this token and **NEVER GIVE IT TO ANYONE** because anyone with this web token will have full access to your account.
3. Log out of this account in that same private tab at https://us.shop.battle.net/?logout
4. Open SimpleD2RLauncher.ps1 and modify `$DISPLAY_NAMES` to a descriptive name that works for you (does **NOT** need to be your email). For example `$DISPLAY_NAMES = @("Hammerdin")`
5. Modify `$WEB_TOKENS` to contain the web token you just copied from step 1 in our case the new value would be `$WEB_TOKENS = @("US-53e84b256e5549ee8dceb3540b15b250-1234567")`
6. Repeat this process for each account. Seperating each display name and web token with a comma and ensuring they are wrapped in double quotes (`$DISPLAY_NAMES = @("Hammerdin", "BO Barb")` and `$WEB_TOKENS = @("US-53e84b256e5549ee8dceb3540b15b250-1234567", "US-931c67313fa4484ba94c6de589477762-7654321")`)

---

**Launching the Game:**
1. Right click on SimpleD2RLauncher.ps1 and run it in powershell. Aprove the UAC prompt if present.
2. You'll now be presented with all of your accounts.
   - To launch ALL of your accounts, just press enter.
   - To launch multiple accounts, type in the corresponding number for each account separated by a space. Eg: 1 3 4
   - To launch a single account type in the number for the account you wish to launch followed by enter.
3. Choose your region.
   - To launch in the default region defined in the `$DEFAULT_REGION`, just press enter.
   - To launch in a different region, type in 1 for Americas, 2 for Europe, or 3 for Asia followed by enter.
4. Once you've hit the character select screen, come back to the powershell window, and press enter to launch the next account. Returning to this powershell window each time you're ready to launch the next account.

![AccountPicker](assets/AccountPicker.png?raw=true "AccountPicker")

---

![RegionPicker](assets/RegionPicker.png?raw=true "RegionPicker")

---

**Work in Progress:**
A set-up video. Coming soon.