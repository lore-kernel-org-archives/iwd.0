Content-Type: multipart/mixed; boundary="===============9066850442434710506=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] eap-tls-common: allow embedded PEMs in settings
Date: Mon, 07 Oct 2019 12:58:09 -0500
Message-ID: <f5d657eb-3477-a07e-6ddb-04eb5bc8087b@gmail.com>
In-Reply-To: <20191007161113.13435-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9066850442434710506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi James,

On 10/7/19 11:11 AM, James Prestwood wrote:
> Refactoring was required to allow for embedded certs. The existing
> eap_tls_state object was changed to hold the cert types (l_queue,
> l_certchain, l_key) rather than the file path, since there may not
> actually be separate PEM files.
> =

> Care was taken to properly manage the memory of these objects.
> Since the TLS object takes ownership when setting auth data or the
> CA certs all error cases must be handled properly to free these
> objects after they are loaded and in addition they must be set to
> NULL so that the cleanup doesn't double free them.
> =

> If everything goes to plan, we load all the PEMs in settings_load,
> provide these objects to the TLS APIs, and then NULL out the
> pointers (TLS now owns this memory). If anything fails between
> settings_load and l_tls_start we must free these objects.
> =

> A special format must be used to indicate that a PEM is embedded
> inside the settings file. First, the l_settings format should be
> followed for the PEM itself, e.g.
> =

> [@pem(a)my_ca_cert]
> <CA Cert data>
> =

> This PEM can then be referenced by "embed:my_ca_cert", e.g.
> =

> EAP-TLS-CACert=3Dembed:my_ca_cert
> =

> Any other value not starting with "embed:" will be treated as a file
> path.
> ---
>   src/eap-tls-common.c | 259 +++++++++++++++++++++++++++++--------------
>   1 file changed, 177 insertions(+), 82 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============9066850442434710506==--

