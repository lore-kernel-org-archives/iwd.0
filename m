Content-Type: multipart/mixed; boundary="===============5661286595847825531=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Treewide: fix typos
Date: Tue, 21 Jan 2020 16:08:08 -0600
Message-ID: <2d998ce0-cf2d-2b2b-4b5e-e66b52fe5393@gmail.com>
In-Reply-To: <20200121062138.21074-1-torstein@huseboe.net>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5661286595847825531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Torstein,

On 1/21/20 12:21 AM, Torstein Huseb=C3=B8 wrote:
> ---
>   autotests/util/testutil.py | 2 +-
>   doc/access-point-api.txt   | 2 +-
>   doc/adhoc-api.txt          | 2 +-
>   doc/features.txt           | 2 +-
>   doc/network-api.txt        | 2 +-
>   doc/station-api.txt        | 2 +-
>   doc/wpa-auth.txt           | 2 +-
>   monitor/nlmon.c            | 6 +++---
>   monitor/pcap.c             | 2 +-
>   plugins/sim_hardcoded.c    | 2 +-
>   src/adhoc.c                | 2 +-
>   src/anqputil.c             | 4 ++--
>   src/eap-mschapv2.c         | 2 +-
>   src/eap-pwd.c              | 2 +-
>   src/eap-sim.c              | 2 +-
>   src/eap-tls-common.c       | 2 +-
>   src/eap-wsc.c              | 2 +-
>   src/erp.c                  | 2 +-
>   src/handshake.c            | 4 ++--
>   src/hotspot.c              | 2 +-
>   src/ie.c                   | 4 ++--
>   src/manager.c              | 4 ++--
>   src/netdev.c               | 6 +++---
>   src/netdev.h               | 2 +-
>   src/network.c              | 2 +-
>   src/sae.c                  | 2 +-
>   src/scan.c                 | 2 +-
>   src/station.c              | 6 +++---
>   src/wsc.c                  | 4 ++--
>   tools/hwsim.c              | 2 +-
>   unit/test-cmac-aes.c       | 4 ++--
>   unit/test-ie.c             | 8 ++++----
>   unit/test-sae.c            | 4 ++--
>   33 files changed, 49 insertions(+), 49 deletions(-)
> =


<snip>

Thanks for taking the time to do this.  Some of the typos were pretty =

funny :)

> --- a/src/handshake.c
> +++ b/src/handshake.c
> @@ -145,8 +145,8 @@ static bool handshake_state_setup_own_ciphers(struct =
handshake_state *s,
>   	s->group_management_cipher =3D info->group_management_cipher;
>   =

>   	/*
> -	 * Dont set MFP for OSEN otherwise EAPoL will attempt to negotiate a
> -	 * iGTK which is not allowe for OSEN.
> +	 * Don't set MFP for OSEN otherwise EAPoL will attempt to negotiate a
> +	 * iGTK which is not allow for OSEN.

I amended your commit to have this become 'allowed' instead of allow and =

applied the rest.

Applied, thanks!

Regards,
-Denis
--===============5661286595847825531==--

