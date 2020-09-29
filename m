Content-Type: multipart/mixed; boundary="===============5538800877134880722=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: add iwmon options
Date: Tue, 29 Sep 2020 09:10:30 -0500
Message-ID: <c1243ff4-6123-0ce0-a1b2-62fb600f67e3@gmail.com>
In-Reply-To: <20200925205233.14909-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5538800877134880722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/25/20 3:52 PM, James Prestwood wrote:
> This extends test-runner to also use iwmon if --log is enabled.
> For this case the iwmon log will be found inside each test
> log directory.
> =

> A new option, --monitor <file> was added in case full logging isn't
> desired (potentially for timing issues) but a iwmon log is needed.
> Be aware that when --monitor is used test-runner will mount the
> entire parent directory. test-runner itself will only write to the
> file specified, but just know that the parent directory is available
> as read-write inside the VM.
> =

> --log takes precedence over --monitor, meaning the iwmon log will
> be written to <logdir>/<test>/iwmon instead of the file specified
> with --monitor if both options are provided.
> ---
>   tools/test-runner | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5538800877134880722==--

