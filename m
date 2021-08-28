Content-Type: multipart/mixed; boundary="===============0221141797435845780=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] auto-t: hwsim.py: turn Hwsim into singleton
 (per-namespace)
Date: Fri, 27 Aug 2021 20:07:45 -0500
Message-ID: <6b7fb971-b165-d885-df9c-c044b0277ce3@gmail.com>
In-Reply-To: <20210826203333.1067317-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0221141797435845780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/26/21 3:33 PM, James Prestwood wrote:
> This prevents reallocation of new Hwsim classes on each call if one
> already exists. This is a bit more efficient on memory.
> ---
>   autotests/util/hwsim.py | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============0221141797435845780==--

