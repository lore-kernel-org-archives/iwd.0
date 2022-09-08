Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30389CB
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 20:37:04 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so3676520pji.1
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=9drzL60YjyloKneOdgDZhKuq65ctZcSUXfyf/X57wgI=;
        b=i7+IB0OFqVC8tFotvhU/d9PUjby0D06YRPEL2vedjDo61BCrt5yDCfoAFz8YT7lpWG
         lgPBMFAf7H3tRuLBZtCysw6lVnLnSc6pSWFKSqjRO6ijN5ID5RmXfAJyBV/J0QschLW0
         yhQH7KtgvffKL6leVPjhmp3HyVvKThH1gEXVjRb+IiDxrHSPdbbfy7CE15O/OrcUNSSe
         niTTXRh9ptwHywhg7R30McwmRC0UuCXbKVQEkNYtZea+zYXHfe0p7CX+Uo72qorq3NiE
         yf5chWuTKFbflX0ys0OiPDAX9FXfGv5o55UobIUHCDAC2drGkOAxyZHGbDugMg0Ga2NX
         qAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=9drzL60YjyloKneOdgDZhKuq65ctZcSUXfyf/X57wgI=;
        b=qvRDbTw6VKL/NbTeN6qa7JF/BjTXB4+G0cgWXTKu4IsjpDLcauWTW7fxX1QQxdVyTV
         nBhziSgSMXsF6SayutOG+2PxuQOKkFljYP4sGHnD4eX/qqavVLuVLUcPBCPa0DfuvgnH
         oyQAee9ijvM1xYyqpoy98ieqioP5yu5MuxVtyea7H9NofLx9ujnNPGbZWDNSXSTfoX73
         88kG1VP2+CawJo+wMog39dMVbX50C4dLwXS0kVw3C/Ult0SCZ/WRpcdOF0IAaZIWRdmH
         NTJU3DN8q67YC4xlb1bk/3Wix1vrXRjzF4vSyJDwItniVfLUK8Ev8l3+fRiLFKtC3YhO
         qozg==
X-Gm-Message-State: ACgBeo1VeRIe+lVfHSww49AFkhCnotnMMYRpkJfvpvoinE7nkcYbtM0N
	NozYKl5kNFjsQbWIbRS7240=
X-Google-Smtp-Source: AA6agR61omX0qoe+wCBMHGRbEDf/mL6KpzW7tsb5pctmVzX8WDUDYo1Kn3ik1FEqs9FB/GmHQ9KMUA==
X-Received: by 2002:a17:902:9b98:b0:176:70e1:1f86 with SMTP id y24-20020a1709029b9800b0017670e11f86mr10305439plp.60.1662669423531;
        Thu, 08 Sep 2022 13:37:03 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78f23000000b0053b2681b0e4sm32355pfr.67.2022.09.08.13.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:37:03 -0700 (PDT)
Message-ID: <9226b42441f9abb14db1a91733b7b55fa1c44e4e.camel@gmail.com>
Subject: Re: Could not start RRM scan error - repeated
From: James Prestwood <prestwoj@gmail.com>
To: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>, "iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Thu, 08 Sep 2022 13:37:02 -0700
In-Reply-To: <AS8PR01MB7493394E25D4B40A14772CA8F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
References: 
	<AS8PR01MB7493D4E15D3465B3B0491B22F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
	 <0913644cbda1bd56a556a3733fd2acbf9ab433f6.camel@gmail.com>
	 <AS8PR01MB7493EE14AFA1C016A6FFA60DF4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
	 <57215da9fd5a65e4b804bd2f4602f2660065c85f.camel@gmail.com>
	 <AS8PR01MB7493394E25D4B40A14772CA8F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2022-09-08 at 20:25 +0000, Johnson, Bryce wrote:
> Hi James,
> 
> > Nothing seems particularly wrong with this request. I but I have a
> > hunch it has to do with restrictions on your device. Its asking for
> > an
> > active scan on frequency 5745. Could you check if this frequency is
> > restricted in any way, e.g. 'iw list'.
> > 
> > For example under section for 5Ghz bands you'll see frequencies
> > listed:
> > 
> > Band 2:
> >       ...
> >       Frequencies:
> >               ...
> >               * 5745 MHz [149] (22.0 dBm) (no IR)
> > 
> > As you can see, mine has a 'no IR' restriction meaning active scans
> > are
> > not allowed. And I don't see that we check this anywhere in IWD, so
> > at
> > the very least we need to do that to prevent the kernel bouncing
> > back
> > the scan request.
> 
> Yeah I think you are on to something! This is a 2.4Ghz only device

Ah ok, thats it then. So IWD needs to be a bit more strict on the
checks here.

> 
>                 Frequencies:
>                         * 2412 MHz [1] (20.0 dBm)
>                         * 2417 MHz [2] (20.0 dBm)
>                         * 2422 MHz [3] (20.0 dBm)
>                         * 2427 MHz [4] (20.0 dBm)
>                         * 2432 MHz [5] (20.0 dBm)
>                         * 2437 MHz [6] (20.0 dBm)
>                         * 2442 MHz [7] (20.0 dBm)
>                         * 2447 MHz [8] (20.0 dBm)
>                         * 2452 MHz [9] (20.0 dBm)
>                         * 2457 MHz [10] (20.0 dBm)
>                         * 2462 MHz [11] (20.0 dBm)
>                         * 2467 MHz [12] (20.0 dBm) (no IR)
>                         * 2472 MHz [13] (20.0 dBm) (no IR)
>                         * 2484 MHz [14] (disabled)
> 
> But the router has the same SSID for both 2.4GHz band and 5Ghz. 
> Router is probably wants me to check if the 5GHz connection would be
> better to move over there if so?

Hard to say why. The AP is just asking "Hey, can you scan on this
channel?".

> 
> I could probably stop the issue by setting my 2.4GHz and 5Ghz ssids
> to have different names in my situation, but I don't know what types
> of networks our product will be installed, so we'd what to make sure
> there it wouldn't cause other issues when this happens in other
> locations.

So this shouldn't cause any functional problems, its just going to
print this warning so I wouldn't worry about doing anything on your
end. IWD just need to reject requests like this and not tell the user
:)

Thanks for reporting this,
James

> 
> Thanks!
> Bryce
> 
> P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.
> 
> This e-mail (including any attachments) is confidential and may be
> legally privileged. If you are not an intended recipient or an
> authorized representative of an intended recipient, you are
> prohibited from using, copying or distributing the information in
> this e-mail or its attachments. If you have received this e-mail in
> error, please notify the sender immediately by return e-mail and
> delete all copies of this message and any attachments. Thank you.


