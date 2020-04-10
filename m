Content-Type: multipart/mixed; boundary="===============8571793836458616284=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] iwd: remove unnecessary semicolons
Date: Fri, 10 Apr 2020 14:49:48 +0000
Message-ID: <27c3d6ab-1d11-1e96-cddc-0e81dbe1a2db@gmail.com>
In-Reply-To: <20200410003831.258910-1-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8571793836458616284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rosen,

On 4/9/20 7:38 PM, Rosen Penev wrote:
> Found with clang's -Wextra-semi-stmt
> ---
>   monitor/nlmon.c | 27 ++++++++++++++++-----------
>   src/crypto.c    |  2 +-
>   src/eapol.c     |  6 +++---
>   src/erp.c       |  2 +-
>   src/fils.c      |  3 ++-
>   src/ie.c        | 10 ++++++----
>   src/main.c      |  2 +-
>   src/sae.c       |  4 ++--
>   src/station.c   |  2 +-
>   src/wsc.c       |  2 +-
>   10 files changed, 34 insertions(+), 26 deletions(-)
> =


Patches 1 & 2 applied, thanks.

Regards,
-Denis

--===============8571793836458616284==--

