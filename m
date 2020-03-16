Content-Type: multipart/mixed; boundary="===============2147270438558477073=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] test-runner: fix crash if ofono is not installed
Date: Mon, 16 Mar 2020 20:22:37 +0000
Message-ID: <dfbe9715-e8e5-cdcf-a256-ec3f4945b171@gmail.com>
In-Reply-To: <20200316192242.15588-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2147270438558477073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/16/20 2:22 PM, James Prestwood wrote:
> The goto was jumping to a label which freed the wiphy list which
> had not yet been initialized. This also fixes another similar issue
> if chdir fails (in this case tmpfs_extra_stuff would get freed
> before being allocated).
> ---
>   tools/test-runner.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============2147270438558477073==--

