Content-Type: multipart/mixed; boundary="===============0485014578025060206=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] auto-t: return None with get_ordered_network(s)
Date: Mon, 28 Oct 2019 15:01:55 -0500
Message-ID: <1c811d47-a8bb-1f14-e7d9-6bd368147727@gmail.com>
In-Reply-To: <20191028195201.21904-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0485014578025060206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/28/19 2:51 PM, James Prestwood wrote:
> If no networks are found, return None rather than an empty
> array. This is easier to check by the caller (and was assumed
> in some cases). Also add an exception to get_ordered_network
> if no network is found.
> ---
>   autotests/util/iwd.py | 7 +++++++
>   1 file changed, 7 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============0485014578025060206==--

