Content-Type: multipart/mixed; boundary="===============3698071505009376232=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] doc: add section about regulatory.db missing
Date: Mon, 07 Oct 2019 11:34:21 -0500
Message-ID: <e9567766-9365-b09f-f7c8-6e20f92bbc1d@gmail.com>
In-Reply-To: <20191007162848.14158-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3698071505009376232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/7/19 11:28 AM, James Prestwood wrote:
> It was found that some distros do not ship with a regulatory.db file.
> This is required to run some of the autotests, and if not found on the
> system the kernel build will fail due to some of the IWD config
> options which require regulatory.db.
> =

> The fix is to manually download regulatory.db from git.kernel.org and
> place it in /lib/firmware.
> ---
>   doc/test-runner.txt | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============3698071505009376232==--

