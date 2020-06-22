Content-Type: multipart/mixed; boundary="===============1415910961244331616=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] test-runner: use WNOHANG option waiting for PID
Date: Mon, 22 Jun 2020 12:03:47 -0500
Message-ID: <fc9d7aee-c3f1-4ca8-fa16-86ffc8e45645@gmail.com>
In-Reply-To: <20200622155050.24787-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1415910961244331616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/22/20 10:50 AM, James Prestwood wrote:
> If an application has a bug and hangs on SIGTERM this causes
> test-runner to hang as well. This is obviously an issue with
> the application in question, but test-runner should have a way
> of continuing onto the next test rather than hanging.
> =

> Instead we can use WNOHANG and a sleep to allow applications
> some amount of time to exit, and if they haven't use SIGKILL
> instead as well as print an error. Similar to how
> wait_for_socket works. The timeout is hard coded to 2 seconds
> (100ms sleep + 20 iterations).
> ---
>   tools/test-runner.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> =

> v2:
>   - Removed extra check for i >=3D 20 since that is always going to be
>     true if we get past the while loop
>   - Added another waitpid after SIGKILL
> =


Applied, thanks.

Regards,
-Denis

--===============1415910961244331616==--

