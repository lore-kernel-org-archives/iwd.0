Content-Type: multipart/mixed; boundary="===============0390079888184504690=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] network: Check if network busy before new connection
Date: Thu, 08 Oct 2020 10:08:46 -0500
Message-ID: <cfcc64d2-9e76-66c0-4117-751b5985200b@gmail.com>
In-Reply-To: <20201008084911.1046485-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0390079888184504690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/8/20 3:49 AM, Andrew Zaborowski wrote:
> Check if we have an ongoing agent call before starting a new connection
> attempt and potentially overwriting network->agent_request.
> ---
>   src/network.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============0390079888184504690==--

