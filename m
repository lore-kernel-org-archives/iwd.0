Content-Type: multipart/mixed; boundary="===============6177740409151847284=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to connect to client network using ell dbus interface
Date: Thu, 12 Aug 2021 09:13:13 -0500
Message-ID: <88027289-b8e1-0ab4-aff9-8e78fb83528d@gmail.com>
In-Reply-To: <20210809114754.2797.47085@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6177740409151847284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen,

On 8/9/21 6:47 AM, salahaldeen.altous(a)leica-camera.com wrote:
> Hi,
> I am trying to integrate station API to my application (C code), I am usi=
ng the interface net.connman.iwd.Station to run a scan() and the interface =
net.connman.iwd.Network to connect() but how I can start a simple agent to =
provide the password? Can you provide me with a complete procedure to conne=
ct to WP2 network using ell dbus binding?

There's an agent implementation that ships as part of our iwctl client.  Se=
e:
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/client/agent.c
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/client/agent-m=
anager.c

ell also ships with a basic dbus service example:
https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/examples/dbus-service.c

Regards,
-Denis
--===============6177740409151847284==--

