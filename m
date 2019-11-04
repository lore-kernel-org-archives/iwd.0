Content-Type: multipart/mixed; boundary="===============1017804892715979278=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] test-runner: log process output to host system
Date: Mon, 04 Nov 2019 14:41:56 -0600
Message-ID: <57ae1be4-5347-90d0-103b-5dfab1050753@gmail.com>
In-Reply-To: <20191104194430.30169-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1017804892715979278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/4/19 1:44 PM, James Prestwood wrote:
> All the processes verbose output is just written to stdout, and very
> hard to parse after the test runs. Having test-runner write the
> processes output to separate log files is much nicer to view after
> the test runs.
> =

> A read/write file system is created which is separate and isolated
> from the current FS mount (which mounts the whole host file system).
> Doing this requires the user to create a folder somewhere to be used
> as the mount point. This folder is where all the log files will end
> up after test-runner runs.
> =

> Since test-runner must be run as root, care was taken to keep the
> log files owned by the user which runs test-runner. The UID/GID
> are passed to the VM, and any log files created are chown'ed back
> to the user who ran test-runner.
> =

> execute_program was refactored, and both verbose and log arguments
> were removed. The verbose argument was not really required since
> we can do check_verbosity(argv[0]) internally. The 'log' flag was
> only used along with --shell, and now the user can simply use
> --log instead of dumping /tmp/iwd.log.
> =

> You can use this feature by specifying --log[=3Dpath] to test-runner.
> If no path is provided the current directory will be used. Using
> the --log flag will result in all processes being run with the
> --verbose flag.
> =

> A new folder will be created under the --log path. The folder will
> be of the name "run-<year>-<month>-<dat>-<PID>". Under this folder
> you will find any global process logs. These are processes that
> are only run once for ALL tests (hwsim, ifconfig, dbus etc.). There
> will also be folders for specific tests that were run. Inside these
> test folders will be logs of processes that are run per-test (iwd,
> hostapd, python etc.).
> ---
>   tools/test-runner.c | 299 ++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 244 insertions(+), 55 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1017804892715979278==--

