Content-Type: multipart/mixed; boundary="===============2242840770672384768=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4] Document P2P dbus interfaces
Date: Mon, 27 Jan 2020 14:59:42 -0600
Message-ID: <08873887-1c47-6469-cfea-a4076b8d6dcf@gmail.com>
In-Reply-To: <20200124034042.2576-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2242840770672384768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/23/20 9:40 PM, Andrew Zaborowski wrote:
> Proposed minimum P2P interfaces for establishing basic connections.  The
> device discovery results in creation of Peer objects.
> ---
> I removed any mentions of WFD or services for now.  I did keep the
> signal level agent as we have all the code in netdev and there's no
> reason not to make the notifications available for client-mode
> connections.  For connections where don't have the data (GO-mode until
> kernel support is there) we will not send them (obviously).
> ---
>   doc/p2p-api.txt      | 97 ++++++++++++++++++++++++++++++++++++++++++++
>   doc/p2p-peer-api.txt | 45 ++++++++++++++++++++
>   2 files changed, 142 insertions(+)
>   create mode 100644 doc/p2p-api.txt
>   create mode 100644 doc/p2p-peer-api.txt
> =


Applied, thanks.

Regards,
-Denis

--===============2242840770672384768==--

