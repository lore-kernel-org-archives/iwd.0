Content-Type: multipart/mixed; boundary="===============4544051986885462005=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: How to NAT when using iwd ap mode?
Date: Thu, 27 May 2021 08:14:26 -0500
Message-ID: <CAG17S_MiVCSBoVB9y3gLaey1H1xyLr2Dwu0WK5BFntPL_aavKQ@mail.gmail.com>
In-Reply-To: <d8eeae0b-0b5f-0835-d0db-dae1b1352a73@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4544051986885462005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 6:34 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Keith,
>
> On 5/25/21 12:21 PM, KeithG wrote:
> > I have been trying to get ap mode to NAT and am unsuccessful. Is this p=
ossible?
> >
> > I can get AP mode to work with this in /etc/iwd/main.conf
> >
> > and I can get an IP address associated and I can connect to the
> > computer running iwd in ap mode. What I cannot do is NAT the wifi
> > connected device to the eth0 which has a valid connection.
> >
> > [General]
> > UseDefaultInterface=3Dtrue
> > EnableNetworkConfiguration=3Dtrue
> > APRanges=3D192.168.5.0/24
> >
> > After I get my AP running and connect, I tried to run these commands
> > to enable NAT:
> >
> > # sysctl net.ipv4.ip_forward=3D1
> > # iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> > # iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACC=
EPT
> > # iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
> >
> > When I try this, I get no 'internet' traffic from eth0.
> >
> > Is this due to dns? Do I need to use iptables to NAT this?
> >
> > When I run connman in tether mode it works. I can connect and I get
> > internet traffic over wlan connected devices. When I have iwd running
> > in AP mode, though, I cannot figure out how to share the eth0
> > connection to the wifi connected device(s).
> >
> > Is there a guide on how to use the ap.iwd provisioning file? I am not
> > clear on how to use it. I created a file: /etc/iwd/ap.iwd and it does
> > not seem to use it. Where do you set the hostname?
> >
>
> There isn't, so I came up with a very simple tutorial.  Feel free to impr=
ove it,
> add on to it, etc.
>
> https://iwd.wiki.kernel.org/ap_mode
>
> Regards,
> -Denis

Denis,

Thanks, google did not help me find that page. It works for me. The
only thing I would ask is: why do we have to set the 'APRanges=3D' in
/etc/iwd/main.conf? Can this be set in ssid.ap? This is the only
setting that I have found that needs to be set in main.conf for ap
mode to work.

Keith
--===============4544051986885462005==--

