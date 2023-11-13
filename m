Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE63219F3
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IufX7VBw"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-586f68b78ddso2616614eaf.2
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 07:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699889892; x=1700494692; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+OfcckTAZN5M6hPLerZRcbvioCSXV0jZVIoFChkF1g=;
        b=IufX7VBwQRDSENLb8IA9IVE13ZbEdG4g1M96RbSCeqqOvSflQCHIqUtlA7VkocGjcF
         D1om5VEqrIIMkrhea/lxr4tCtHl+WZRZ7r0VDwcuZZKZJCcfarlUC7zVbdm8XMbUiLdH
         t38+va87UAubQ9aMf0qy2qs63k9YSrU4EWymPl0dfNIugGp8nSmkrOhlAZ3DjU+ooOYA
         yKJdjBzVKmFOuIU/m1I1hR1xjhvN+j1EgWRiGGcsdANijbnzySmYABURcbiOIrS7wx26
         uDo639836egR5k+X+3EmIAF472yBWoMqlsVZEEPyRU3WAiELdFxDcRWhxkHsiBnKC1Mp
         4hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699889892; x=1700494692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+OfcckTAZN5M6hPLerZRcbvioCSXV0jZVIoFChkF1g=;
        b=SMOQ1TP89KVMgopxi6S8262SqYNHzdzGlnd49ofGThaEcu4k9HXAUATw7zYIf0Z7NZ
         xFjZv9Xlak4Tg7TzID5BpP9lnbOWMrOSXcPEuXaTcFYlY4NPCzEuny8bKFJ6z59QzgJY
         HORbNCG/yAWl1f6U1Vt0mkvBHwgPF32iJGjqt3axbn9Jd8Up5J1fXTAXfbVOeiIyIyCT
         iwjcsCAPLqFPG1HlW4oeH9vB1FO4MhKF00++S99zBvDrfRZKV1I97ThlrhWGntU4RUY+
         uqwugf4Qpu1uucvSkiUisPgyUrvhWlnmcD33ciPXD7glhwn3vd2vhF32iLrDrG5Lny1n
         OhJw==
X-Gm-Message-State: AOJu0YyTD72lDSTuYY6Jj8JC8bAN/ucJYPAVmjoqud95aMglDCEiVX7w
	ruOVqAa04wzAf/Gwp6F5oBk=
X-Google-Smtp-Source: AGHT+IFaiQJ0Cnf6TGhKo0qtuV8x/3Wm9ZMieEMu3e0R8ISMtQIYFg9D4tYzLPbg7FT5+ZLIywWPiA==
X-Received: by 2002:a4a:3056:0:b0:582:99ae:ca47 with SMTP id z22-20020a4a3056000000b0058299aeca47mr5751327ooz.3.1699889891839;
        Mon, 13 Nov 2023 07:38:11 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v8-20020a4a8c48000000b00581df2cb1e6sm1005803ooj.32.2023.11.13.07.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:38:11 -0800 (PST)
Message-ID: <92eb9b97-5602-4194-a884-b7a97a440e69@gmail.com>
Date: Mon, 13 Nov 2023 09:38:09 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <ALSI@bang-olufsen.dk>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Dimitrios Karnikis <DIKA@bang-olufsen.dk>,
 Claudio Cabral <CLCA@bang-olufsen.dk>, =?UTF-8?Q?Pedro_Andr=C3=A9?=
 <PEDA@bang-olufsen.dk>, Johnny Kudahl <JOY@bang-olufsen.dk>,
 "achyut.hegde@nxp.com" <achyut.hegde@nxp.com>,
 "yuvraj.singh@nxp.com" <yuvraj.singh@nxp.com>
References: <20230403141927.235014-1-alvin@pqrs.dk>
 <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
 <lrv3ytp7a6jvuupcu4pvx2w5jmud4yj6jxbk4imflcqeuosugo@vu7fco6auklk>
 <4d8b889f-0b31-409b-93d1-7a06051adf9e@gmail.com>
 <b4e0927f-b319-48a4-b300-1b319b1c7185@gmail.com>
 <068ee7ac-298a-4bab-971f-e4c797dbdd4b@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <068ee7ac-298a-4bab-971f-e4c797dbdd4b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James, Alvin,

On 11/13/23 09:29, James Prestwood wrote:
> Hi Denis,
> 
> On 11/13/23 7:26 AM, Denis Kenzior wrote:
>> Hi James,
>>
>>>
>>> Ok this does make sense to me. A disconnect from the AP could come in at any 
>>> point during reassociation (during the ROAMING state). I think we assume the 
>>> kernel handles this during the actual association step, i.e. relays this in 
>>> the connect event, but during eapol/key setting I think your original patch 
>>> holds some merit.
>>>
>>> Just so we have public record I've sanitized the logs you sent (removed 
>>> dates, hostnames, driver prints), and its clear that a disconnect at this 
>>> moment would trigger this "Unexpected disconnect" case:
>>>
>>> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_start()
>>> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_link_notify() event 16 on ifindex 8
>>> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=8
>>> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=8
>>> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_gtk() ifindex=8 key_idx=1
>>> iwd[3589]: ../iwd-2.8/src/station.c:station_handshake_event() Setting keys
>>> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_tk() ifindex=8 key_idx=0
>>> iwd[3589]: ../iwd-2.8/src/station.c:station_handshake_event() Setting keys
>>> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_tk() ifindex=8 key_idx=0
>>
>> Why is set_tk being called twice?  Or is this a copy-paste artifact?
> 
> Hmm, good question. I didn't notice that but its called 2x in the logs Alvin 
> sent me. Alvin, was it a copy-paste error on your side? If not something weird 
> is going on.
> 

We're generating the Setting keys event twice.  I don't really understand how 
this can happen, honestly.  I hope this is an artifact of some sort.

Anyhow, I think overall the patch approach is incorrect.  When we are roaming, 
we expect the callback provided to netdev_reassociate() to be invoked on any 
error.  So the real fix is in netdev.c somewhere.

Regards,
-Denis

