Content-Type: multipart/mixed; boundary="===============0995227477426353493=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] p2p: Send the right UUID-E in probe request WSC IEs
Date: Tue, 25 Aug 2020 16:53:38 -0500
Message-ID: <5f15a7cd-2263-143c-90ef-f994e3bc97e5@gmail.com>
In-Reply-To: <20200825024534.484304-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0995227477426353493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/24/20 9:45 PM, Andrew Zaborowski wrote:
> When building the scan IEs for our provisioning scans, use the UUID-E
> based on the Interface Address, not the Device Address, as that is what
> wsc.c will be using to in the registration protocol.
> =

> Eventually we may have to base the UUID-E on the Device Address or
> something else that is persistent, and pass the actual UUID-E to wsc.c,
> as the Interface Address is randomly generated on every connect attempt.
> IIRC the UUID-E is supposed to be persistent.
> ---
>   src/p2p.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> =


All applied, thanks.

Regards,
-Denis

--===============0995227477426353493==--

