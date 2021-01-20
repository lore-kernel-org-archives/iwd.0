Content-Type: multipart/mixed; boundary="===============5710867091572238116=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] doc: document AccessPointDiagnostic interface
Date: Wed, 20 Jan 2021 14:00:50 -0600
Message-ID: <df3e52f3-afdd-6376-5129-35bd877e54b1@gmail.com>
In-Reply-To: <20210120183036.477287-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5710867091572238116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/20/21 12:30 PM, James Prestwood wrote:
> ---
>   doc/access-point-diagnostics.txt | 36 ++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 doc/access-point-diagnostics.txt
> =


<snip>

> +
> +Methods		dict[] GetDiagnostics()
> +

For historical reasons the preferred syntax for this is array{dict}, so I m=
ade =

this changed and applied, thanks!

Regards,
-Denis

--===============5710867091572238116==--

