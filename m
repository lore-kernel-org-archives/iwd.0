Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA6F512
	for <iwd@lists.linux.dev>; Sun, 24 Dec 2023 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT6eJbDV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-427d5bfe24cso2185991cf.1
        for <iwd@lists.linux.dev>; Sun, 24 Dec 2023 11:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703447799; x=1704052599; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=45G3o2/gM+au069Sn8iEevoZejDsvHaf2J687qJzkR8=;
        b=dT6eJbDVN0znG96If7h+/kvanbW0AO6OZjx5z2SgOQqCoBn7koUlqs4JfmwBtTdewX
         ts9nZU24jQYocpSCChRbpsTL0kTSu/kWdMb3XC3co7c63SWpVdpDgZ7mczVya0piD4jo
         uP7Z0PWDq6r4So/bAT7Raqa83oVvRInEv/GxFdt6hLjqiVZdq1h8/xt4mQu7U/aAhOMv
         Z8yIC4TvBOQ2Oq/95S3jA8y+kZa4mh5MskOIY0XRbksHBYH1Znc/ycK7bNPWGB1+/3St
         l2B9+2oKXXNFFAdWBB6XQtB6mys7ng+3jDkQNk61FI8W589X5KUtweNugAXCMXc1jnqu
         /kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703447799; x=1704052599;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45G3o2/gM+au069Sn8iEevoZejDsvHaf2J687qJzkR8=;
        b=ttTnytXgZFfPrkmf5NKbZ8hZziWp3GB0swXsjdk/BX7w2OLAmFSTJw4t1rPk28AvwY
         agtqbJInh51blbsOmeV+husBkvl18JiHIjxL4fbZ1nYG9SjkiuIHf5Vl3IfX1IGYhJWt
         M2klGC0vt6xqv7TKEDxCMCq9IZG0j84J9h+NINe5oxfxNaxQdUeZ8zW36JZ7S/Ebi8fj
         GU6EmuqZMnYh5fMnW39loVh6koya0igZqZoAf6UP+uVRgQexB4ebzFkmYSmpz4wUSLuY
         Dp7UODVR4+9TuflPESTiReWhf4izhuBIcd7HpXVvoO9EU6+e3B2VG3Us0GaAEjBZVkTV
         J+bA==
X-Gm-Message-State: AOJu0Yz+tJTN5acrpgtQ5Bp38SKCWQm2y8T/Wy/7VLkGYCn++uoPZo8Y
	pYOZICpXLpA8JMrwlAY8y0dx3GBwQZzgyCRjbT3jk266bGo=
X-Google-Smtp-Source: AGHT+IG1A5EZRdJm/bQhpATx0oNWZZ9ydDJeGwtocbW3GQfTJQLRQtN4mBA/DGtl/VWBBPrPJ8M+xan8us8DobAhb3M=
X-Received: by 2002:ac8:7fc3:0:b0:423:94f9:f0ce with SMTP id
 b3-20020ac87fc3000000b0042394f9f0cemr8564057qtk.10.1703447799537; Sun, 24 Dec
 2023 11:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 24 Dec 2023 13:56:28 -0600
Message-ID: <CAG17S_Moeg81aYr3zk+Uzk_Ocin9uXT=05-xJRLcix5F6Ba_kQ@mail.gmail.com>
Subject: should the dbus responses be the same for ap scan and station scan?
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Group,

I am trying to get connman to scan for networks regardless if iwd is
on station or ap mode. Somewhat recently, this capability was added to
iwd and it works. The problem I am trying to resolve is that I want
the networks to appear in connman so that we can select it and set a
password then reboot to get our appliance to connect.
I am a novice coder, and not too conversant in dbus, so my hypothesis
is that connman will need the same formats in order to process the
ssids and allow us to select and set it up. If I am way off base let
me know, but can this be set up in iwd so that they all appear the
same way.

What I notice when sniffing the dbus is that the responses are
different depending on the mode iwd is in
:
in station mode:

# iwctl station wlan0 scan
# iwctl station wlan0 get-networks
                               Available networks
--------------------------------------------------------------------------------
      Network name                      Security            Signal
--------------------------------------------------------------------------------
      bob1                                   psk                 ****
      XFINITY                           8021x               ****
...

and the dbus messages look like this:

method call time=1703445730.045045 sender=:1.114 ->
destination=net.connman.iwd serial=1 path=/;
interface=org.freedesktop.DBus.ObjectManager; member=GetManagedObjects
         object path "/net/connman/iwd"
               string "net.connman.iwd.Daemon"
               string "net.connman.iwd.AgentManager"
               string "net.connman.iwd.p2p.ServiceManager"
         object path "/net/connman/iwd/0"
               string "net.connman.iwd.Adapter"
         object path "/net/connman/iwd/0/3"
               string "net.connman.iwd.Device"
                     variant                         object path
"/net/connman/iwd/0"
               string "net.connman.iwd.Station"
               string "net.connman.iwd.SimpleConfiguration"
               string "net.connman.iwd.DeviceProvisioning"
         object path "/net/connman/iwd/0/3/4e4554474541523231_psk"
               string "net.connman.iwd.Network"
                     variant                         object path
"/net/connman/iwd/0/3"
...
whereas when in ap mode, it looks like this:

# iwctl ap wlan0 scan
# iwctl ap wlan0 get-networks
                                    Networks
--------------------------------------------------------------------------------
            Property              Value
--------------------------------------------------------------------------------
            Name                  bob1
            SignalStrength        -4100
            Type                  psk
...

and dbus looks like this:

method call time=1703444647.560016 sender=:1.2005 ->
destination=net.connman.iwd serial=1 path=/;
interface=org.freedesktop.DBus.ObjectManager; member=GetManagedObjects
         object path "/net/connman/iwd"
               string "net.connman.iwd.Daemon"
               string "net.connman.iwd.AgentManager"
               string "net.connman.iwd.p2p.ServiceManager"
         object path "/net/connman/iwd/0"
               string "net.connman.iwd.Adapter"
         object path "/net/connman/iwd/0/3"
               string "net.connman.iwd.Device"
                     variant                         object path
"/net/connman/iwd/0"
               string "net.connman.iwd.AccessPoint"
               string "net.connman.iwd.AccessPointDiagnostic"
method call time=1703444652.382809 sender=:1.2010 ->
destination=net.connman.iwd serial=1 path=/;
interface=org.freedesktop.DBus.ObjectManager; member=GetManagedObjects
         object path "/net/connman/iwd"
               string "net.connman.iwd.Daemon"
               string "net.connman.iwd.AgentManager"
               string "net.connman.iwd.p2p.ServiceManager"
         object path "/net/connman/iwd/0"
               string "net.connman.iwd.Adapter"
         object path "/net/connman/iwd/0/3"
               string "net.connman.iwd.Device"
                     variant                         object path
"/net/connman/iwd/0"
               string "net.connman.iwd.AccessPoint"
               string "net.connman.iwd.AccessPointDiagnostic"
method call time=1703444652.384805 sender=:1.2010 ->
destination=net.connman.iwd serial=3 path=/net/connman/iwd;
interface=net.connman.iwd.Daemon; member=GetInfo
method call time=1703444652.385567 sender=:1.2010 ->
destination=net.connman.iwd serial=4 path=/net/connman/iwd;
interface=net.connman.iwd.AgentManager; member=RegisterAgent
method call time=1703444652.386267 sender=:1.2010 ->
destination=net.connman.iwd serial=5 path=/net/connman/iwd/0/3;
interface=net.connman.iwd.AccessPoint; member=Scan
         variant             string "/var/lib/iwd"
signal time=1703444652.389041 sender=:1.51 -> destination=(null
destination) serial=139 path=/net/connman/iwd/0/3;
interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "net.connman.iwd.AccessPoint"
method call time=1703444656.341365 sender=:1.2012 ->
destination=net.connman.iwd serial=1 path=/;
interface=org.freedesktop.DBus.ObjectManager; member=GetManagedObjects
         object path "/net/connman/iwd"
               string "net.connman.iwd.Daemon"
               string "net.connman.iwd.AgentManager"
               string "net.connman.iwd.p2p.ServiceManager"
         object path "/net/connman/iwd/0"
               string "net.connman.iwd.Adapter"
         object path "/net/connman/iwd/0/3"
               string "net.connman.iwd.Device"
                     variant                         object path
"/net/connman/iwd/0"
               string "net.connman.iwd.AccessPoint"
               string "net.connman.iwd.AccessPointDiagnostic"
method call time=1703444656.345039 sender=:1.2012 ->
destination=net.connman.iwd serial=3 path=/net/connman/iwd;
interface=net.connman.iwd.Daemon; member=GetInfo
method call time=1703444656.345422 sender=:1.2012 ->
destination=net.connman.iwd serial=4 path=/net/connman/iwd;
interface=net.connman.iwd.AgentManager; member=RegisterAgent
method call time=1703444656.346386 sender=:1.2012 ->
destination=net.connman.iwd serial=5 path=/net/connman/iwd/0/3;
interface=net.connman.iwd.AccessPoint; member=GetOrderedNetworks
         variant             string "/var/lib/iwd"
signal time=1703444656.437348 sender=:1.51 -> destination=(null
destination) serial=145 path=/net/connman/iwd/0/3;
interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "net.connman.iwd.AccessPoint"
