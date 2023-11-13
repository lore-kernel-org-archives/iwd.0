Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC521372
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGhmbz6Z"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b6cfc62514so1496924b6e.0
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699889168; x=1700493968; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wsSwAbdBoSdKGOMpLoCv3sLhA5nyQXaZxl/FV+/sMQ=;
        b=dGhmbz6ZodGq5zrQ3jIiGYgg3BcPWaF23IN9b6v/G06RFRi/MdN4hfFGvAOS1KSiML
         +sMw2AtIU+OFNsRG/zcnN9ERTdtZRimkJbq06Uk6FS6UyPbLmyN4j61VuF+wH0W7tJ2+
         2IG96tBitvRDwzHQnDUSacW6Ga8KWgl9y9QRpw/SFXRGp2xuINpGBQmKmelgJqHRM45n
         H5ZuyrDpQ0IWnyplUa4iMbQALaf85J6VxA13yP8bXklnkriZTFR2Cc5DzJmE4C3esWO1
         8GXh9T2i1A0JGoXGDVBckhqi2VKljlRJ8EeVe7JksNKdxCnzpW/sRDLl4V9jT6EOTE/m
         iNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699889168; x=1700493968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wsSwAbdBoSdKGOMpLoCv3sLhA5nyQXaZxl/FV+/sMQ=;
        b=W/17jN3Kf1MfBGl7pQ6ir4fHYWQEpxLLB2f7ASbjkwAWyMeX7VhXy5AI70zkARRPRO
         iP8PeSvdH4aCzBzlaG8Zl2SwTbF1aGtpUz70DY8/FkukCTBD/vGLjX2TiUDl3EZGXPKT
         8c1n9FID73aYOCs3pWvwjpbu9mffhvO06Cy8gDIvbv89gtEOYEXUCqZyG7AxRzqMtDLu
         2GesVTL3YABaf0XHo6HC5qePmm418WrGhr1P4KHXKBUNcrBBAY+wvSrCMda95XEXQpzd
         UGiYvRdEFyPh0NG9WHlgSTPWArmw8pHM40HQMTbIzjeTq6TLw811SmRnGTL4hNZsR7nB
         J2fg==
X-Gm-Message-State: AOJu0Yy3b5GHW0OwP7tyiLou0cf06qw3MqOOjmWWWt1x+YQcVi4pU9hP
	AuP3Wx12G9q1N5x/xmJG8dU=
X-Google-Smtp-Source: AGHT+IGaIhrqfbfKfT0gcr48RtsI/5gjao2o5nMlrihKkkF9hmADD3puEe+BHsyhdBYumpmCakihpg==
X-Received: by 2002:a05:6808:13c3:b0:3b2:f500:6ee0 with SMTP id d3-20020a05680813c300b003b2f5006ee0mr5458770oiw.28.1699889168074;
        Mon, 13 Nov 2023 07:26:08 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a9-20020a05680804c900b003b29c2f50f0sm817449oie.18.2023.11.13.07.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:26:07 -0800 (PST)
Message-ID: <b4e0927f-b319-48a4-b300-1b319b1c7185@gmail.com>
Date: Mon, 13 Nov 2023 09:26:06 -0600
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
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <4d8b889f-0b31-409b-93d1-7a06051adf9e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> Ok this does make sense to me. A disconnect from the AP could come in at any 
> point during reassociation (during the ROAMING state). I think we assume the 
> kernel handles this during the actual association step, i.e. relays this in the 
> connect event, but during eapol/key setting I think your original patch holds 
> some merit.
> 
> Just so we have public record I've sanitized the logs you sent (removed dates, 
> hostnames, driver prints), and its clear that a disconnect at this moment would 
> trigger this "Unexpected disconnect" case:
> 
> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_start()
> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_link_notify() event 16 on ifindex 8
> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=8
> iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=8
> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_gtk() ifindex=8 key_idx=1
> iwd[3589]: ../iwd-2.8/src/station.c:station_handshake_event() Setting keys
> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_tk() ifindex=8 key_idx=0
> iwd[3589]: ../iwd-2.8/src/station.c:station_handshake_event() Setting keys
> iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_tk() ifindex=8 key_idx=0

Why is set_tk being called twice?  Or is this a copy-paste artifact?

Regards,
-Denis
