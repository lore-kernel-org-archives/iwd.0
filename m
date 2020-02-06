Content-Type: multipart/mixed; boundary="===============2470022168324716832=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] peap: Ensure TLV uniqueness
Date: Thu, 06 Feb 2020 10:28:58 -0600
Message-ID: <a9c6e45b-e194-eb56-8ab7-d824b78f0102@gmail.com>
In-Reply-To: <20200205231905.30996-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2470022168324716832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 2/5/20 5:19 PM, Tim Kourt wrote:
> Processing the duplicated TLVs while connecting to a malicious AP may lead
> to overflow of the response buffer. This patch ensures that the
> duplicated TLVs are not parsed.
> ---
>   src/eap-peap.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============2470022168324716832==--

