Content-Type: multipart/mixed; boundary="===============8383344206877312243=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] knownnetworks: copy network_config on update
Date: Thu, 29 Jul 2021 17:38:09 -0500
Message-ID: <a43e24e2-87fe-229d-fcb0-4c51c37ac63d@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8383344206877312243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/29/21 5:21 PM, James Prestwood wrote:
> The network_config was not being copied to network_info when
> updated. This caused any new settings to be lost if the network
> configuration file was updated during runtime.
> ---
>   src/knownnetworks.c | 2 ++
>   1 file changed, 2 insertions(+)

All applied, thanks.

Regards,
-Denis

--===============8383344206877312243==--

