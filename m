Content-Type: multipart/mixed; boundary="===============2375416907250125495=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/6] plugins: remove dependency on ELL plugins
Date: Wed, 16 Sep 2020 14:33:46 -0500
Message-ID: <2980af26-2684-b673-3a42-052f46b1d374@gmail.com>
In-Reply-To: <20200916193945.683476-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2375416907250125495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/16/20 2:39 PM, James Prestwood wrote:
> There has been a desire to remove the ELL plugin dependency from
> IWD which is the only consumer of the plugin API. This removes
> the dependency and prepares the tree for converting the existing
> ofono plugin into a regular module.
> =

> sim_hardcoded was removed completely. This was originall implemented
> before full ofono support purely to test the IWD side of EAP-SIM/AKA.
> Since the ofono plugin (module-to-be) is now fully implemented there
> really isn't a need for sim_hardcoded.
> ---
>   Makefile.am              |   8 +-
>   bootstrap-configure      |   1 -
>   configure.ac             |   5 -
>   plugins/sim_hardcoded.c  | 399 ---------------------------------------
>   src/main.c               |  16 --
>   {plugins =3D> src}/ofono.c |   0
>   6 files changed, 1 insertion(+), 428 deletions(-)
>   delete mode 100644 plugins/sim_hardcoded.c
>   rename {plugins =3D> src}/ofono.c (100%)
> =

> -v2:
>   * Removed sim_hardcoded all together
> =


All applied, thanks.

Regards,
-Denis

--===============2375416907250125495==--

