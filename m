Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1A848B
	for <iwd@lists.linux.dev>; Fri, 26 May 2023 15:04:14 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-64d57cd373fso1641476b3a.1
        for <iwd@lists.linux.dev>; Fri, 26 May 2023 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685113453; x=1687705453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=el1g3oYKiZ4ihm9baq/U9DXaRJEpcbxmX8eW6tCKmg8=;
        b=J/xUiz8ZzOQFgEdCs20DtsNLZQmdmjt1P7KlBvM2p2TqW2P9zn/Ao6ovMnro6dgZal
         BL2hfXLv5hTytJbdyE2KGYEjFjZfl7RK20Ko6m2N1oSJD0jE5VTOY7BxydIfPbm65pRO
         nOG3Cm8mQz5lv0YmEbaHhf9i4jxnL1GA9pXfphXbcK31Ke/30hS9/R/2hqHZEIAW7eAc
         nfAHqIJ2bUvRgT+QErXHPF/7A62tdMZaquH2nCqrT6t11WXdGOEFXuTEOh3nyfXpMZOA
         sYLGm1C/36x0dPQHJEtzyM8WJaI0IFEQkjD2282loEENWnetbikh/uJuWM8yC5Ubvs8Z
         Ox8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113453; x=1687705453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=el1g3oYKiZ4ihm9baq/U9DXaRJEpcbxmX8eW6tCKmg8=;
        b=UHc3oOVZE+BAVc3eh2SN7qBYWwYcWWcj7Vpshe/rNenyFn9tu865oM6BoJ8vvdRYpS
         vOpbBH6dtUBGy6/GcO4goIM1Kw7tM3FzlbvfwrOgXf8S3D5G6U4bvuhmoZvm7VjVz5FY
         7b7n9wCotq4kVYriKsMbP//+oG3YuOH7VdHLTRmKOfjJK6l5PsbsJ9AnTWhUgZPkSF/w
         9Jp0cVB/CW+esHNPDUhqR+eo2a4XWCYaMmTAJKBxVj2b4Sl6/YmScQIp+rSc13uTcIm3
         wUmvbDJkmZFrZb7DUA3R4J5TaEbEv/GXk5rZ0myHLDajfhdR4lRiVjTZGFMOH0xoF5Kd
         GF2Q==
X-Gm-Message-State: AC+VfDz12v3NbBCXia1m+q8JFCS6rQsPdl+syrIutRLit2Gn8ztmqChP
	RiI/vFsb5O39zONBTxsit1lSOOS1s/gvzg==
X-Google-Smtp-Source: ACHHUZ51m51WPrpSY9vIgtwYOojZkvAf24x2MLHt0dTjxMpSd61U9in8VdKbAe+0YMg92aMX7rs0gQ==
X-Received: by 2002:a05:6a20:729e:b0:10e:dc7d:cbbe with SMTP id o30-20020a056a20729e00b0010edc7dcbbemr2762198pzk.25.1685113453540;
        Fri, 26 May 2023 08:04:13 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id i20-20020a63cd14000000b00528db73ed70sm2913744pgg.3.2023.05.26.08.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 08:04:13 -0700 (PDT)
Message-ID: <b64f3233-699a-a081-5d37-cbcad70ada66@gmail.com>
Date: Fri, 26 May 2023 08:04:12 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: wifi disconnects periodically
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAG17S_Nrg_PCVFR1UZLROME+TuKy5_3N=JgfBkLF2cpZaiaTVw@mail.gmail.com>
 <951f5c65-7648-ea55-6eed-feaa615bc7f5@gmail.com>
 <CAG17S_ObjJ8AJZtYwBuFgNO5pMU3_ufA_EOtUzDoQ11vcJXT2g@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_ObjJ8AJZtYwBuFgNO5pMU3_ufA_EOtUzDoQ11vcJXT2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 5/26/23 8:03 AM, KeithG wrote:
>>
>> Its hard to say, there isn't much to go on here. I'd suggest running IWD
>> in debug mode and seeing if we can get any more info from that.
>>
>> If your using IWD for DHCP you might also start IWD with
>> IWD_DHCP_DEBUG=debug set in case its got something to do with a DHCP renew.
>>
>> Thanks,
>> James
>>
> James,
> 
> I enabled debug 'iwd -d' and will see how it goes. If it happens
> again, I'll hopefully have a log of it.
> I enabled -d as opposed to the IWD_DHCP_DEBUG because I am using
> connman to manage the interfaces. Isn't this correct that connman is
> actually managing the DHCP?

Yep, no need for IWD_DHCP_DEBUG in this case.

> 
> Keith
