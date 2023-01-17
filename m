Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E28D52D
	for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 18:28:53 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id d8so2102140pjc.3
        for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 10:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8Px8HqP8puoU92DX6hHgozD7ezxYkMwrWwo7JrHwMM=;
        b=ftiqw3X5FVVqzrRPmZmEiAa9m65l8m/AiklDDNGGspwT7pZWJeflY4/C+qKH/vIy0O
         NxJAtkvKU+UnXJHQ6rNfsxToqQnxiyp+223vGJ3s0EMPDif9vMWH1UygActbqlKoEATo
         eCe7qCxBxi3fbYLrWEwyi86QC7NeNqoliT4mKMciWqaJiyZShrX7qCjGQgb35Xg5xKA6
         GGLuExNa2zVQfD2SrIrXyhZgbOgZ2yeMqfOOSQfeKBoTZCZfR2zeFhWDN4X+y6/HoYUJ
         Sr9CNdzQA/3JQTjIP6bgNd4bSKWs1iPnr/skz0hOSCSmf0qPgyPIHZcGrVQRNSm633dJ
         KYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8Px8HqP8puoU92DX6hHgozD7ezxYkMwrWwo7JrHwMM=;
        b=KbhUlfKG33WuN2Wnpg6DlL/EZaWqkn6biNGFVnzTBFVDUeLILOWkOFTueczaL4ThCM
         VSSShtcMPvWHP9pw1UQ+pU/qK700UHEvmQ1NWcmnuerWi0xYk5ZJC9bIMcKZvUFDxd0J
         ANhIERNHzcslV3J8BymzFdIHheet6xYCQaWfpZhHZxAsPhcOT8wdkIr+ErxCfwL+ixib
         9jsLafcb52dkSuBd9AqDBabBs6STfGPOrqEs9CRg4+GJPHQWD3vttrTRT2RmWxluqD7a
         CNvEGFdG3isDTybM3ezWPLNOXZABcsMT6eC5wjAl8w0ux9+VR94AZIttJGfuS2oegXPS
         9n7Q==
X-Gm-Message-State: AFqh2koNkgdv71lHca0TF69Co1W3iLvJxphMlUTEPoCVcj16z6DJ8Mn8
	zdRDz5BnMFbMhZ+9P/9YKVU=
X-Google-Smtp-Source: AMrXdXvGcjJIBMQvkBV/g7kdLPv0JDjwfSr6CtUzjmi2NFV7B9hPIobFWngPJlQs1hO7ZO6eJ5QXCQ==
X-Received: by 2002:a17:903:1315:b0:194:8bd7:3236 with SMTP id iy21-20020a170903131500b001948bd73236mr4486767plb.45.1673980133475;
        Tue, 17 Jan 2023 10:28:53 -0800 (PST)
Received: from [192.168.254.20] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001895d871c95sm21479386plg.70.2023.01.17.10.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:28:52 -0800 (PST)
Message-ID: <c14b6ea2528aa47ddb8e0266128d39848aba7fef.camel@gmail.com>
Subject: Re: IWD AP is not working with NXP (88W8997/88Q9098),  START_AP
 failed: -14
From: James Prestwood <prestwoj@gmail.com>
To: "Altous, Salahaldeen" <Salahaldeen.Altous@leica-camera.com>, 
	"iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Tue, 17 Jan 2023 10:28:52 -0800
In-Reply-To: <AM7PR01MB67244F63EBEAB9A65D965BEAADC69@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
References: 
	<AM7PR01MB672451F58D20BA27F874E4B2ADC19@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
	 <AM7PR01MB67244F63EBEAB9A65D965BEAADC69@AM7PR01MB6724.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 2023-01-17 at 10:55 +0000, Altous, Salahaldeen wrote:
> Hi all, 
> 
> I am testing now IWD-2.0 with an ublox module Jody-W377 (chipset NXP-
> Q9098) and using the open-source driver from NXP (mwifiex),station mode
> is working fine but I have problem with starting AP (CMD_RESP: cmd 0xb1
> error, result=0x1; START_AP failed: -14). I have in the past used the
> iwd with Qualcomm/Intel chipset with no problem. Does IWD support NXP-
> Q9098?
> attached you can find the log from iwd and iwctl

I did a quick look around in that driver for -EFAULT (the error you're
seeing) and nothing jumped out at me.

I don't have any mwifiex hardware to try, but I don't see why it
shouldn't work. Have you tried hostapd? If hostapd works, then we will
need a iwmon log from both hostapd (working) and IWD (not working).
Then we can compare what differs between the two.

Thanks,
James

> 
> can you please check what is the needed information from wlan driver
> and is missing (not set) in mwifiex driver?
> 
> Also using 2 interfaces will fail when starting iwd and only one
> interface will be listed with device list
> # /usr/libexec/iwd -i mlan0 -i uap0 &
> Wireless daemon version 1.12
> station: Network configuration is disabled.
> Wiphy: 0, Name: mwiphy0
>           Permanent Address: 20:4e:f6:bb:0c:2f
>           Bands: 2.4 GHz 5 GHz
>           Ciphers: CCMP TKIP BIP
>           Supported iftypes: station ap p2p-client p2p-go
> Wiphy mwiphy0 will only use the default interface
> 
> [Note]
> If only starting iwd with uap0 , uap0 can be listed
> [iwd]# device list 
>                                     Devices                            
>        
> -----------------------------------------------------------------------
> ---------
>   Name                  Address               Powered     Adapter    
> Mode      
> -----------------------------------------------------------------------
> ---------
>   uap0                  00:50:43:20:13:34     on          mwiphy0    
> ap   
> 
> 
> Best Regards,
> Salahaldeen
> 
> --
> Mit freundlichen Gruessen / kind regards
> 
> M.Sc Salahaldeen Altous
> Senior Embedded Linux Developer
> Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
> Vorstand | Executive Board: Matthias Harsch (CEO) I Michael Grimm (CFO)
> Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr.
> Andreas Kaufmann
> This message may contain confidential and privileged information. If it
> has been sent to you in error, please notify the sender immediately by
> replying to the message and please delete it from your computer. 


