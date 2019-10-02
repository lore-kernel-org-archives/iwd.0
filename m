Content-Type: multipart/mixed; boundary="===============6308892281562434669=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/2] eap-tls-common: update to new ELL TLS APIs
Date: Wed, 02 Oct 2019 10:43:13 -0500
Message-ID: <294fb92d-6673-22c5-e5a1-cc6270157938@gmail.com>
In-Reply-To: <20191001213809.8471-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6308892281562434669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/1/19 4:38 PM, James Prestwood wrote:
> ---
>   src/eap-tls-common.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> =

> -v3:
>   * Fixed the ca_cert cleanup, l_certchain_free was being used rather
>     than l_cert_free.
> =


I ended up pushing my own version of this that was extra paranoid.  The =

issue is that since the certificates are on disk, we can't simply assume =

that they will be loaded successfully (as they might have been =

inadvertently or maliciously changed between the time check_settings and =

tunnel_init are called).

It might actually make sense to load the keys at load_settings time or =

(or even earlier) to avoid extra latency during connection setup time.

Please review.

Regards,
-Denis
--===============6308892281562434669==--

