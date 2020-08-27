Content-Type: multipart/mixed; boundary="===============2363470152081537303=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/11] eap-wsc: In WSC-R read UUID-E from settings
Date: Thu, 27 Aug 2020 14:03:39 -0500
Message-ID: <c7d3383e-ef0f-a19c-5eab-181cee2bbdf1@gmail.com>
In-Reply-To: <20200827181453.61823-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2363470152081537303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> The intent was to read the UUID-E from the settings rather than generate
> it from the enrollee's MAC because it needs to match the UUID-E from
> enrolee's Probe Requests, fix this.  The UUID-E supplied in the unit
> test was being ignored but the test still passed because the supplied
> UUID-E was generated the same way we generated it in eap-wsc.c.
> ---
>   src/eap-wsc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> =


Patch 3, 5, 6 applied, thanks.

Regards,
-Denis

--===============2363470152081537303==--

