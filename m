Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9391BDDA
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbNqgiVv"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-41cd4446cf5so4170531cf.3
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697809078; x=1698413878; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OvesDyRsZBMaI3zqdO/WHTFO9hVwXOwInyA3IPnihpg=;
        b=YbNqgiVvyZuIX9T9vuiGJCIBb6kG9ghhrmDV/I0qKUsaYoJ2WA5AF2qfzHsKXD5rGa
         +PfN759tujcux4Y3PSEbFO5LYZwmHKQSGuH0SY5ONDwlZ9S1mNtaGtIerN70bIfklp7/
         X5N3SJlbHr4h7svQXaTikZSvd4vDDMqGcIi+/a8nx+NY5IUQusI9u4LpDQVHO28/LDdS
         AJpy3pGWWU3Atn4bNMkhyu14HJndANizc8URjkCLbJB1s+Xc3eRfwQl2SRVFJMBbnuQc
         ZTcYfQ7HVIAY43NG/Lz3UadvzgMzeqdT2wuaypsE8Tl4znK32juWXHaGjNB6DR/fXG6U
         2Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809078; x=1698413878;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvesDyRsZBMaI3zqdO/WHTFO9hVwXOwInyA3IPnihpg=;
        b=J8ih7a+32Pl+NL+gDoyOfUAkhIdfdwoIbf7oe5lMrN3T1IzI7eWZ+ZUdZDIR099v2e
         HxM8aNQtqjRzEZV/utIeoZOaja8Ih9b606q3h+Nb21sUUnJUKcbW+AvN7IiLkJrRpUVc
         8mLsFROUvsksUzAlcqTQ9k4CQwocMANc0lSOaqsNlf1b5jqfikZwErieUL8PMYB8/qqp
         XRFY2MOfs6F9FxYKmlHZibQaTidUgDJoyYV6uWNH3WmjCn0i1GCmB4PUHukL9NYTX92s
         WvLPMFKLKA1aQ8/3vb+bTtJGh6zxc5iKu8QS/1mPludn1fVkjfG10yIGOdZ+I1HApntM
         cgAw==
X-Gm-Message-State: AOJu0YzBwxPLtzPI4eNs9Libj7l/+LtiWqni+XiAe3B3eCy3hbzpQ6Cy
	GpU9KSRqAZXTYnvKuIpj8LU3Z5l9Z5vQU56i0go53c5Mq5+/xQ==
X-Google-Smtp-Source: AGHT+IHOiLhDPBIdL5uWKCATBskqA7yAAuSIZj+PS0nH5nxyGNzgGniqWgZXnKOcJti4MJnsTKcNuYSjLG1QsFZwHO8=
X-Received: by 2002:ac8:5e0b:0:b0:417:b269:4689 with SMTP id
 h11-20020ac85e0b000000b00417b2694689mr1394617qtx.53.1697809077507; Fri, 20
 Oct 2023 06:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Fri, 20 Oct 2023 15:37:46 +0200
Message-ID: <CA+iibzCp0HZwBsoGM7i4k8v86JJWoDC7UDrEMsnqOoezKLcnyg@mail.gmail.com>
Subject: iwctl interactive mode error
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000f6630e060825fa6e"

--000000000000f6630e060825fa6e
Content-Type: text/plain; charset="UTF-8"

Hi gents

After compiling iwd at the last commit I have tried to see the status
of the network with the iwctl command. When I launch the command i
have thisantoine@grat-os1:~$ iwctl

Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
[iwd]# NetworkConfigurationEnabled: disabled
[iwd]# [iwd]# StateDirectory: /var/lib/iwd
[iwd]# [iwd]# Version: 2.8
[iwd]#

The prompt [iwd]# is repeated several times and when I try to enter a
command I got this message
Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
[iwd]# NetworkConfigurationEnabled: disabled
[iwd]# [iwd]# StateDirectory: /var/lib/iwd
[iwd]# [iwd]# Version: 2.8
[iwd]# station list
bck:sta

if I force the command it's worse
Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
[iwd]# NetworkConfigurationEnabled: disabled
[iwd]# [iwd]# StateDirectory: /var/lib/iwd
[iwd]# [iwd]# Version: 2.8
[iwd]# station list
[iwd]# s[iwd]# s                            Devices in Station Mode
                       *
[iwd]# s[iwd]# s----------------------------------------------------------------------------------------------------
[iwd]# s[iwd]# s  Name                  State            Scanning
         ing
[iwd]# s[iwd]# s------------------------------------------------------------------------------------------------
[iwd]# s[iwd]# s  wlan0                 connected
[iwd]# s[iwd]# s
[iwd]# s[iwd]# s[iwd]# s[iwd]# s stati[iwd]# stati

It looks like the tab is active all the time and tries to send
commands repeatedly . The screen is garbled and there is a click at
each tab

The result of a help command
[iwd]# helpd]# s[iwd]# s[iwd]# s stati[iwd]# stati
[iwd]# [iwd]#
[iwd]# [iwd]#                                iwctl version 2.8
[iwd]# [iwd]# --------------------------------------------------------------------------------
[iwd]# [iwd]#   Usage
[iwd]# [iwd]# --------------------------------------------------------------------------------
[iwd]# [iwd]#   iwctl [--options] [commands]
[iwd]# [iwd]#
[iwd]# [iwd]#                                Available options
[iwd]# [iwd]# --------------------------------------------------------------------------------
[iwd]# [iwd]#   Options                                             Description
[iwd]# [iwd]# --------------------------------------------------------------------------------
[iwd]# [iwd]#   --username
Provide username
[iwd]# [iwd]#   --password
Provide password
[iwd]# [iwd]#   --passphrase
Provide passphrase
[iwd]# [iwd]#   --dont-ask
Don't ask for missing
                                              credentials
[iwd]# [iwd]#   --help                                              Display help
[iwd]# [iwd]#
[iwd]# [iwd]#                                Available commands
[iwd]# [iwd]# --------------------------------------------------------------------------------
[iwd]# [iwd]#   Commands                                            Description
[iwd]# [iwd]# --------------------------------------------------------------------------------
[iwd]# [iwd]#
Adapters:
[iwd]# [iwd]#   adapter list
List adapters
[iwd]# [iwd]#   adapter <phy> show
Show adapter info
[iwd]# [iwd]#   adapter <phy> set-property <name> <value>           Set property
[iwd]# [iwd]#
Ad-Hoc:
[iwd]# [iwd]#   ad-hoc list
List devices in Ad-hoc mode
[iwd]# [iwd]#   ad-hoc <wlan> start <"network name"> <passphrase>
Start or join an existing
[iwd]# [iwd]#
Ad-Hoc network called "network
[iwd]# [iwd]#
name" with a passphrase
[iwd]# [iwd]#   ad-hoc <wlan> start_open <"network name">
Start or join an existing open
[iwd]# [iwd]#
Ad-Hoc network called "network
[iwd]# [iwd]#                                                       name"
[iwd]# [iwd]#   ad-hoc <wlan> stop
Leave an Ad-Hoc network
[iwd]# [iwd]#
Access Point:
[iwd]# [iwd]#   ap list
List devices in AP mode
[iwd]# [iwd]#   ap <wlan> start <"network name"> <passphrase>
Start an access point called
[iwd]# [iwd]#
"network name" with a
[iwd]# [iwd]#                                                       passphrase
[iwd]# [iwd]#   ap <wlan> start-profile <"network name">
Start an access point based on
[iwd]# [iwd]#                                                       a
disk profile
[iwd]# [iwd]#   ap <wlan> stop
Stop a started access point
[iwd]# [iwd]#   ap <wlan> show                                      Show AP info
[iwd]# [iwd]#   ap <wlan> scan
Start an AP scan
[iwd]# [iwd]#   ap <wlan> get-networks
Get network list after
[iwd]# [iwd]#                                                       scanning
[iwd]# [iwd]#
Devices:.......

I am able to launch the command in non interactive mode without problem
antoine@grat-os1:~$ iwctl ap list
                          Devices in Access Point Mode
--------------------------------------------------------------------------------
  Name                  Started
--------------------------------------------------------------------------------
No devices in access point mode available.
CY^E
antoine@grat-os1:~$ iwctl dpp list
                              DPP-capable Devices
--------------------------------------------------------------------------------
  Name
--------------------------------------------------------------------------------
  wlan0
^T^XA\^E
 but there is strange characters at the end of the command display

There are no compilation errors. I send you my Pkgfile for iwd. I have
tried to test with version 2.7 and it's the same.

Libedit has been upgraded to version 20230828-3.1 I don't know if it
is related to.

Best regards

Daniel

--000000000000f6630e060825fa6e
Content-Type: application/octet-stream; name=Pkgfile
Content-Disposition: attachment; filename=Pkgfile
Content-Transfer-Encoding: base64
Content-ID: <f_lnyneprk0>
X-Attachment-Id: f_lnyneprk0

bWFrZWRlcGVuZHM9KGRidXMgcHl0aG9uLWRvY3V0aWxzIHJlYWRsaW5lKQoKZGVzY3JpcHRpb249
IkludGVybmV0IFdpcmVsZXNzIERhZW1vbiIKdXJsPSJodHRwczovL2dpdC5rZXJuZWwub3JnL2Nn
aXQvbmV0d29yay93aXJlbGVzcy9pd2QuZ2l0LyIKCnBhY2thZ2VyPSJZYW9saW51eCBUZWFtIgpt
YWludGFpbmVyPSJEYW5pYSIKCm5hbWU9aXdkCnZlcnNpb249Mi44CgojTGFzdCBjb21taXQgb24g
aXdkIHJlcG8KX2NvbW1pdDE9MmM3YmYyNzU2ZTJiOTE5MTE2MTVkYjlmZTA4Mjk3NjAxZDQ5M2M5
OAoKI0xhc3QgY29tbWl0IG9uIGVsbCByZXBvCl9jb21taXQyPWViMTM5ZTIzYWJmMzVlYzhiZjky
MmZjNjQwYWExMjkyODI2MjI1YTMKCnByZXBhcmUoKSB7CiAgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saWJzL2VsbC9lbGwuZ2l0IGVsbAoKICBjZCBlbGwKICBnaXQg
Y2hlY2tvdXQgJHtfY29tbWl0Mn0KCiAgY2QgLi4KCiAgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9uZXR3b3JrL3dpcmVsZXNzL2l3ZC5naXQgaXdkCgogIGNkIGl3ZAog
IGdpdCBjaGVja291dCAke19jb21taXQxfQoKICBhdXRvcmVjb25mIC1maXYKfQoKYnVpbGQoKSB7
CiAgY2QgaXdkCgogIC4vY29uZmlndXJlIC0tcHJlZml4PS91c3IgXAogICAgICAgICAgICAgIC0t
c3lzY29uZmRpcj0vZXRjIFwKICAgICAgICAgICAgICAtLWxvY2Fsc3RhdGVkaXI9L3ZhciBcCiAg
ICAgICAgICAgICAgLS1saWJleGVjZGlyPS91c3IvbGliL2l3ZCBcCiAgICAgICAgICAgICAgLS1l
bmFibGUtd2lyZWQgXAogICAgICAgICAgICAgIC0tZW5hYmxlLW9mb25vIFwKICAgICAgICAgICAg
ICAtLWVuYWJsZS1od3NpbSBcCiAgICAgICAgICAgICAgLS1lbmFibGUtbGliZWRpdCBcCiAgICAg
ICAgICAgICAgLS1kaXNhYmxlLXRvb2xzCgogIG1ha2UKICBtYWtlIGluc3RhbGwgREVTVERJUj0k
UEtHCgogIGluc3RhbGwgLWRtNzAwICRQS0cvdmFyL2xpYi9lYWQvCiAgaW5zdGFsbCAtZG03MDAg
JFBLRy92YXIvbGliL2l3ZC8KfQo=
--000000000000f6630e060825fa6e--
