Content-Type: multipart/mixed; boundary="===============0117239887339580973=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] Fix a side channel leak on the password in SAE
Date: Mon, 03 Aug 2020 16:18:03 -0500
Message-ID: <303a455c-96ce-ed05-f61f-bf766923f805@gmail.com>
In-Reply-To: <20200803090836.62977-1-daniel.de-almeida-braga@irisa.fr>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0117239887339580973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 8/3/20 4:08 AM, Daniel DE ALMEIDA BRAGA wrote:
> Use a constant control flow in the derivation loop, avoiding leakage
> in the iteration succesfuly converting the password.
> Increase number of iterations (20 to 30) to avoid issues with
> passwords needing more iterations.
> Updated to take account of ELL's patch modifications.
> ---
>   src/sae.c  | 135 +++++++++++++++++++++++++++++++++++++----------------
>   src/util.h |  31 ++++++++++++
>   2 files changed, 125 insertions(+), 41 deletions(-)
> =


I re-formatted some of the comments to fit on 80 char lines and applied thi=
s =

patch.  Thanks!

Regards,
-Denis

--===============0117239887339580973==--

