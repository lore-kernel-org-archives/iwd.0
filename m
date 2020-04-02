Content-Type: multipart/mixed; boundary="===============3322886427853560430=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] nlmon: fix -Wformat under musl 1.2.0
Date: Thu, 02 Apr 2020 00:31:19 -0500
Message-ID: <cae1b91f-178f-428c-a315-736aec831171@gmail.com>
In-Reply-To: <20200402021650.790030-1-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3322886427853560430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rosen,

On 4/1/20 9:16 PM, Rosen Penev wrote:
> musl 1.2.0 uses 64-bit time, even under 32-bit OSes. Cast to int64_t
> and use the proper macro.
> ---
>   monitor/nlmon.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============3322886427853560430==--

