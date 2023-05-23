Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254C4A84C
	for <iwd@lists.linux.dev>; Tue, 23 May 2023 12:58:14 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C23EACD85A
	for <iwd@lists.linux.dev>; Tue, 23 May 2023 12:50:05 +0000 (UTC)
Received: (Authenticated sender: florian.coste@nairwolf.net)
	by mail.gandi.net (Postfix) with ESMTPSA id 10CC3C000E
	for <iwd@lists.linux.dev>; Tue, 23 May 2023 12:49:57 +0000 (UTC)
Message-ID: <43a3d110-4e6d-f50c-be66-3bf1d0499983@nairwolf.net>
Date: Tue, 23 May 2023 14:50:30 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: iwd@lists.linux.dev
Content-Language: en-US
From: Florian Coste <florian.coste@nairwolf.net>
Subject: Unable to connect to a EAP-PEAP network
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm trying to setup a wireless connection to a EAP-PEAP network. My 
company gave me this picture as the only documentation available, so I'm 
trying to replicate this NetworkManager GUI setting that you can find 
here: https://i.imgur.com/KB38bDr.png

Basically, it should be:
* Authentication EAP-PEAP
* No certificate
* Inner authentication: MSCAPV2

The SSID of the network I'm trying to connect is called "Company 
France", so I have a file located at "/var/lib/iwd/Company 
France.8021x". There is a space in the SSID but I belive it should not 
cause any issue as soon as the file name and the SSID is matching.

Here's the .8021x config file I'm using: 
https://iwd.wiki.kernel.org/networkconfigurationsettings#eap-peap_with_tunneled_eap-mschapv2

In case I made a mistake by copying/pasting the config, I've pushing 
what I'm using here: http://ix.io/4ww1

I'm launching iwd in debug mode and I see two issues I'm unable to 
understand.

First, when I'm writing the file, I have the following error: "Error 
loading /var/lib/iwd//Company France.8021x". Is there a typo somewhere, 
the log doesn't explain why the file couldn't be loaded. Here's the full 
log: http://ix.io/4wvU

Second issue I have is when I'm trying to connect to this SSID. In the 
config file, I don't have username and password set, so iwd ask me them 
when I'm trying to connect.

Then I have this error: EAP negotiation stopped after the Identity 
exchange, this can happen when the EAP-Identity value is not what the 
authenticator expects

You can find complete logs here: http://ix.io/4wvX

Could you help me to understand what's going on ? My first intution is I 
have a dubious typo in the 8021x file but I'm unable to find it.

Thanks for your help in advance.

