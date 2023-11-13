Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663921358
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHJWCE0I"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-777745f1541so299706185a.0
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699889360; x=1700494160; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PW8jffskswKRXosmBMcBSz8CaqPd9Anvxv6bkb8t1DE=;
        b=IHJWCE0IR8DJV3UYB5ykoGxzXy+OVfZQ6zZlTSmPSFCw9jQ1JZMVLmmPKg4vBG/1I+
         UasoYnYniGoJV+vKtwCp8FG58EJSesUWONouJj/LHdkDPdbEQjjYBYxyFkST14v/B+vr
         mRd01qPxddajParB24+f01Au7Gj4fXrESir9xSmp/A7lxHe5Kb+xjBu8KJ+YLAD5HJSE
         6egixvJKqseLgAmL80RrjUUui45THC8H7BQbnoCTRC1/9b9pfKRbl1ubW8sBvZJT6jPx
         0UoiYLOU2QO3nUPVhXz1fJ8nHUTaj/5AmwbqNYOU3Ekwt+kIwxPU95eJbFMe9Q71/OY1
         03Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699889360; x=1700494160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PW8jffskswKRXosmBMcBSz8CaqPd9Anvxv6bkb8t1DE=;
        b=sgTICtvSMtzoDwiOKnYJhJefgO/N35ZuuBIxIgz2qed8jWSNu7wss2jdMTpRuF86Af
         I5vB7lHc3qAUs2wa8mk6h1EJnaDW5O4yNj5FvclX+KtSu/pVwyDCoQ6vT21mOuAvw3+Z
         QoDCPz6ug0+tMy77pVms9owpWxsiF+1k6oa+KgsEM4ahVmI4QOBf8pWvrjDKkaD7eDZy
         4LUJLvamWlGxRYtZTHZqY8NCOM6dsROA3dso1stLcFQDG/Z4OjrPCZL5bLOI2Z8gHab7
         mx3iNvfGNJ95Q9psfMsmo0G43exs4+d7FJmD/1ZJw3vTIWUASFghhVPKMpTJ5X3I7edJ
         XcGw==
X-Gm-Message-State: AOJu0Yy+Hsoja3XynQnEVn7QeOlmukS9pRxZFQY60z5U505DXBa2a5Ym
	dM1UOASpHg/BAAY27ISd4jI=
X-Google-Smtp-Source: AGHT+IGIsyp4EAWyk1/MrJA97n8pdJqEAEzpS2/zIezIlEOT1HVPhJ+QgSioh2GME5FVUURM+apO2g==
X-Received: by 2002:ad4:5a4e:0:b0:671:cc80:c59d with SMTP id ej14-20020ad45a4e000000b00671cc80c59dmr6825653qvb.0.1699889360326;
        Mon, 13 Nov 2023 07:29:20 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r6-20020ad45226000000b0065d0dcc28e3sm2124293qvq.73.2023.11.13.07.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:29:19 -0800 (PST)
Message-ID: <068ee7ac-298a-4bab-971f-e4c797dbdd4b@gmail.com>
Date: Mon, 13 Nov 2023 07:29:14 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <b4e0927f-b319-48a4-b300-1b319b1c7185@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/13/23 7:26 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> Ok this does make sense to me. A disconnect from the AP could come in 
>> at any point during reassociation (during the ROAMING state). I think 
>> we assume the kernel handles this during the actual association step, 
>> i.e. relays this in the connect event, but during eapol/key setting I 
>> think your original patch holds some merit.
>>
>> Just so we have public record I've sanitized the logs you sent 
>> (removed dates, hostnames, driver prints), and its clear that a 
>> disconnect at this moment would trigger this "Unexpected disconnect" 
>> case:
>>
>> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_start()
>> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_link_notify() event 16 on 
>> ifindex 8
>> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=8
>> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=8
>> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_gtk() ifindex=8 key_idx=1
>> iwd[3589]: ../iwd-2.8/src/station.c:station_handshake_event() Setting 
>> keys
>> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_tk() ifindex=8 key_idx=0
>> iwd[3589]: ../iwd-2.8/src/station.c:station_handshake_event() Setting 
>> keys
>> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_tk() ifindex=8 key_idx=0
> 
> Why is set_tk being called twice?  Or is this a copy-paste artifact?

Hmm, good question. I didn't notice that but its called 2x in the logs 
Alvin sent me. Alvin, was it a copy-paste error on your side? If not 
something weird is going on.

Thanks,
James

> 
> Regards,
> -Denis
