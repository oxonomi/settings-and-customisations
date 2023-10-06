const { exec } = require('child_process');

// Fetch the latest changes from the remote without merging or modifying the working directory
exec('git fetch origin', (fetchErr) => {
  if (fetchErr) {
    console.log("gitcompare: No Github remote repo, local only");
    return;
  }

  // Get the name of the current branch
  exec('git rev-parse --abbrev-ref HEAD', (branchErr, branchStdout) => {
    if (branchErr) {
      console.error(`gitcompare: Branch Error: ${branchErr}`);
      return;
    }

    const currentBranch = branchStdout.trim();
    // console.log("currentBranch: ", currentBranch);
    const remoteBranch = `origin/${currentBranch}`;
    // console.log("remoteBranch: ", remoteBranch);

    // Get the latest commit hash from the local branch
    exec('git rev-parse HEAD', (localErr, localStdout) => {
      if (localErr) {
        console.error(`gitcompare: Local rev-parse Error: ${localErr}`);
        return;
      }
      const localCommit = localStdout.trim();

      // Get the latest commit hash from the remote branch
      exec(`git rev-parse ${remoteBranch}`, (remoteErr, remoteStdout) => {
        if (remoteErr) {
          console.error(`gitcompare: Remote rev-parse Error: ${remoteErr}`);
          return;
        }
        const remoteCommit = remoteStdout.trim();

        // Compare the local and remote commit hashes
        if (localCommit === remoteCommit) {
          console.log(`gitcompare: Local(${currentBranch}) and Remote(${remoteBranch}) are in sync.`);

        } else {
          // Get the timestamps of the local and remote commits
          exec(`git show -s --format=%ci ${localCommit}`, (localTimeErr, localTimeStdout) => {
            if (localTimeErr) {
              console.error(`gitcompare: Local time fetch Error: ${localTimeErr}`);
              return;
            }
            const localTime = new Date(localTimeStdout.trim());

            exec(`git show -s --format=%ci ${remoteCommit}`, (remoteTimeErr, remoteTimeStdout) => {
              if (remoteTimeErr) {
                console.error(`gitcompare: Remote time fetch Error: ${remoteTimeErr}`);
                return;
              }
              const remoteTime = new Date(remoteTimeStdout.trim());

              // Compare the timestamps
              if (localTime > remoteTime) {
                console.log(`gitcompare: Most recent commit (${currentBranch}|${remoteBranch}) is in the local branch.`);
              } else {
                console.log(`gitcompare: Most recent commit (${currentBranch}|${remoteBranch}) is in the remote branch.`);
              }
            });
          });
        }
      });
    });
  });
});
