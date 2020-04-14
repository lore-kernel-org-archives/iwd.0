Content-Type: multipart/mixed; boundary="===============0807998013157087846=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/3] auto-t: Use proper connection status indicator
Date: Tue, 14 Apr 2020 16:21:33 +0000
Message-ID: <5ac9bdc2-30c3-cf36-ca6f-857e4aeb4a89@gmail.com>
In-Reply-To: <20200414011645.22321-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0807998013157087846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 4/13/20 8:16 PM, Tim Kourt wrote:
> 'Connected' property of the network object is set before the connection
> attempt is made and does not indicate a connection success. Therefore,
> use device status property to identify the connection status of the devic=
e.
> ---
>   autotests/testHotspot/autoconnect_test.py | 30 +++++++++++++-----------=
------
>   1 file changed, 13 insertions(+), 17 deletions(-)

All applied, thanks.

Regards,
-Denis

--===============0807998013157087846==--

