Content-Type: multipart/mixed; boundary="===============1342683737176156199=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] station: set preparing_roam flag on Roam()
Date: Fri, 06 Aug 2021 22:38:54 -0500
Message-ID: <b36b8b99-4050-0a1a-a695-a3313faf21be@gmail.com>
In-Reply-To: <20210806230212.381657-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1342683737176156199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/6/21 6:02 PM, James Prestwood wrote:
> The preparing_roam flag is expected to be set by a few roam
> routines and normally this is done prior to the roam scan.
> The Roam() developer option was not doing this and would
> cause failed roams in some cases.
> ---
>   src/station.c | 3 +++
>   1 file changed, 3 insertions(+)

Applied, thanks.

Regards,
-Denis

--===============1342683737176156199==--

