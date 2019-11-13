Content-Type: multipart/mixed; boundary="===============1278053355890419260=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: make --log take a required argument
Date: Wed, 13 Nov 2019 12:37:16 -0600
Message-ID: <affc8832-6155-4a31-cee4-cfb0da2cbca1@gmail.com>
In-Reply-To: <20191113175550.20873-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1278053355890419260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/13/19 11:55 AM, James Prestwood wrote:
> This was a mistake in the original implementation. Since test-runner
> is always run from the tools directory using --log with no directory
> specified would result in many log files being put into the iwd tree.
> =

> Instead we can make --log take a required argument so its more
> obvious where all the logs are going to go.
> ---
>   tools/test-runner.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============1278053355890419260==--

