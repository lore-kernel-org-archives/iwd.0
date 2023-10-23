Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C023DE
	for <iwd@lists.linux.dev>; Mon, 23 Oct 2023 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6RTxJK7"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-41ccd38eaa5so27419731cf.0
        for <iwd@lists.linux.dev>; Mon, 23 Oct 2023 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698068972; x=1698673772; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kC/v/QGsHcOvbcrbnLdvtbQflsPxst9PdIX55Th3s8k=;
        b=N6RTxJK7TOix/9QUy+pE2ESgN/PuscBlOtfyaFHuR1VIjEx/mofATFNCLlVvJQXfn4
         NhLzW5tjJ9gxbzLZUBfw7frcl0xUnbqL16G7B8sPFWBx9Yt/o7FJWSvcXR6rEFL/b6zJ
         QVX47fBnWP1lJr+u32yVWrlEjbhSPrRv3tMeK1upfymLSNpsJF0bNZOugiD5qf977U8N
         v6Kjy2IQmbNmP6iP+y9lMwwUaZUpYRP2PsDwpgqJzIcRb/2JVeQSn3gdaShFBXRlGyQb
         x4uMc+g8AwZMVH8agl3Jond/lkJ4s4uFAjMsLsuA85vk0LRiByaHwcNSWgLkfcbcIDLD
         HaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068972; x=1698673772;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kC/v/QGsHcOvbcrbnLdvtbQflsPxst9PdIX55Th3s8k=;
        b=rJtPCXip1PlKQ09owcEmjCZfBxoFQTU3ay8FtsEBmeelYJ68+nSt/jlBVHOeX8uvM1
         imd9xZmCTimWsoNGxUGGXHKNPKaKZae7ag2UB/Dq1crVfulLAtTY0inLx29n1dKaSmPq
         rrHeEkdK271ptdvqPAJU8r+ANvCsiKzGXhk0F55nHOjp/g3lT6r/dLQ7gwSqf7+XWHbD
         L+QKxM/0RwltE68k6v5/7EGVEPUyskDR02xiSdUj7bhuC71ntep/AseqGU8EtX0WEvCP
         IiSIHRT0A3atDEOTzVdKbG53yBy0sise9kE691SzPKudiOc7Ojqb1Qfk/UDYtuwxz5vz
         uYQQ==
X-Gm-Message-State: AOJu0YzXUUNRGBK491qq3wlKJcsXddMhhBcfjXl4nucvPesUkt7TR891
	kUea6jIn8TXo7EcB5aISjZA=
X-Google-Smtp-Source: AGHT+IEmoSh2HJAPvwV8w97bNLK0kTHWaLyp4X3H/SI6YI1eBmnFT/PfWyx60DDgB59BcqB0AEyWtA==
X-Received: by 2002:a05:622a:58a:b0:407:c2e2:2a06 with SMTP id c10-20020a05622a058a00b00407c2e22a06mr17881830qtb.8.1698068971993;
        Mon, 23 Oct 2023 06:49:31 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id k6-20020ac80746000000b004199f47ccdbsm2729462qth.51.2023.10.23.06.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 06:49:31 -0700 (PDT)
Message-ID: <3a488d09-a66b-452c-99e4-a7521c80252c@gmail.com>
Date: Mon, 23 Oct 2023 06:49:29 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
 <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
 <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
 <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
 <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
 <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
 <c8617f8d-0c7c-4e1c-ab0f-f356a121afe6@gmail.com>
 <ae7b807f-fb7b-4437-9e00-bc4f64ad6047@gmail.com>
 <d4fdadd8-dc2b-47b0-b1ac-114abed91f39@gmail.com>
 <7de9faab-5863-48f5-8de6-28e1b543d2b8@gmail.com>
 <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

> 
>>
>> I'm fine with it as an argument to the StartConfigurator API. An agent 
>> could work but we've also got the optional identifier to think about. 
>> I'd prefer to use the existing agent API for getting a passphrase 
>> rather than a new method.
>>
> 
> But the identifier is not supposed to be secret?

No, the identifier is sent plaintext:

"Optionally, a non-secret identifier for the code can be transmitted to 
support the case where a PKEX implementation may be provisioned to 
connect to a plurality of devices and needs to know which code to use to 
process a received PKEX frame. If an optional code identifier is used, 
it shall be a UTF-8 string not greater than eighty (80) octets that is 
provisioned at the same time as the shared code."

> 
> Regards,
> -Denis
