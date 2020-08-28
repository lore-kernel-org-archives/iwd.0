Content-Type: multipart/mixed; boundary="===============6551003417184732591=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] wscutil: Use a utility for building authorized_macs
Date: Fri, 28 Aug 2020 10:55:15 -0500
Message-ID: <5bbeb3a5-2843-adaf-814d-0e063102b0e2@gmail.com>
In-Reply-To: <20200828124649.78677-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6551003417184732591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/28/20 7:46 AM, Andrew Zaborowski wrote:
> Add the wfa_build_authorized_macs function (wfa_ prefix following the
> wfa_extract_ naming) and use it in wsc_build_probe_response.  The logic
> is changed slightly to treat the first 6-zeros address in the array as
> the end of the array.
> ---
>   src/wscutil.c | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============6551003417184732591==--

