Content-Type: multipart/mixed; boundary="===============1242921298114361391=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] eapol: Remove assumption of single cipher in
 authenticator IE
Date: Fri, 29 Jan 2021 20:28:21 -0600
Message-ID: <25c34b3b-edf3-49de-8ed2-071ed03c878f@gmail.com>
In-Reply-To: <20210129232740.27393-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1242921298114361391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/29/21 5:27 PM, Andrew Zaborowski wrote:
> Allow the user of the eapol_sm & handshake_state APIs to have multiple
> pairwise ciphers listed in the authenticator IE.  This comes at the cost
> of requiring the user to call handshake_state_override_pairwise_cipher
> to select the cipher when setting up the handshake state.

That's unfortunate.  Why would we want to override pairwise_ciphers selecte=
d by =

the STA?  I mean we can maybe do this for testing, but in the general case? =

Furthermore, why would the override API be _required_?

What precludes us from advertising an RSNE with multiple pairwise ciphers a=
nd =

then honoring the single pairwise_cipher that the STA chose?

> ---
>   src/adhoc.c     |  1 +
>   src/ap.c        |  2 ++
>   src/eapol.c     | 20 +++++++++++++++-----
>   src/handshake.c | 25 +++++++++++++++----------
>   src/handshake.h |  2 ++
>   5 files changed, 35 insertions(+), 15 deletions(-)
> =


Regards,
-Denis
--===============1242921298114361391==--

