Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B23C3D
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:43:54 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id bd16so23208849oib.6
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dA3U04Gh8RrGAdiAYtjSQympZcyVSG+diL0nbhdhKFY=;
        b=m3ESy6SDquU268NZbUChbc28iB5nFjg1gg90Afy+yn+F/8eDlsxpYZv3cWRS70+n1q
         zWin9BjSVkMYd8z8y5sqLYhoFfcWZ4WmYZAOCltHC7/VTQTOVs1t78Z/Vea7anMu4qoH
         euKWgWK5D0FpaLgd/+z76FDM2F2rLl9AGP1DHS/h0PApo53rOmcozcX7MEeihfmDA8IP
         oa2nBRqqK6AnmrBZYUAmvUscFdDHpmvYhPCBE+Ev6wKhZ0DRSsQqKbuU9uPJTq+/9Jdk
         QBXzONMUHDo3ZKTJtXNcZ5SKwj+bKBehdpBBXlWWuEg8flNn4ZrpEVmKoYPzuip/C5vD
         NXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dA3U04Gh8RrGAdiAYtjSQympZcyVSG+diL0nbhdhKFY=;
        b=K+UtFzEMbXtNSVkbBBms5FHVqW+MmXuXIv5wKu12OxjIU1vCObndoqgSbWXL3fYwhE
         1284gOEXSNCvN1j+SD/tklqPaVcHr5fbA63LZCp4piFPUxIlrxCVrLaFDZJgPiSGdj6x
         Uk7iIWt59PCUR0kJyj+QZk7Qzk3RNle42wpT4EqjlTPXu2zMKCK/fUWHxJUJlhiXIRZ5
         r5TuWSwAcbTsqID3AIBE2VqJe6uUxAuebXT1jFimfCGiiEyKYfkcNwvq9DJcj/j9Z0vH
         4SHW3taGwCly+ww7yMGRHD9MtDPSqMEMqzkYjCh06GDD5Zw55VY/Q9m1VHgwuIUywAFW
         6maA==
X-Gm-Message-State: AJIora9Fzp/jQPYYMg5AiK8SMGJgG1NGfpcjd7/HY7FvP8fm0hhRFF5D
	5gc5qLw1rJ+I/CqHrUb4rVI=
X-Google-Smtp-Source: AGRyM1u1loNC6sLegaAZQdBnvE+yQILkTRNy4MQJOl6CyAqtkZ1XNYQ0w0IVo+wuVmDLoOvveEei5Q==
X-Received: by 2002:a05:6808:1145:b0:333:28e0:ea2a with SMTP id u5-20020a056808114500b0033328e0ea2amr573649oiu.184.1655941433571;
        Wed, 22 Jun 2022 16:43:53 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 187-20020a4a14c4000000b0042568efdaccsm1241151ood.15.2022.06.22.16.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 16:43:53 -0700 (PDT)
Message-ID: <35dd37dc-5be9-b9dc-7dd7-7bf7b7369b9d@gmail.com>
Date: Wed, 22 Jun 2022 18:28:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 14/15] autotests: Add bad netconfig settings scenario
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-14-andrew.zaborowski@intel.com>
 <a0ee1952ace452c971d98cc208bd9d9eac1a3e92.camel@gmail.com>
 <CAOq732KZuR=cqNnozGDdnR94AAgh-B2Hu0patzN3smL_oSf=rQ@mail.gmail.com>
 <51dc9302-29e1-134c-7358-65ebdaae4db9@gmail.com>
 <CAOq732Japcdcb2Y-j4KgtDV1Vb2ciwW2AEJCRCzzfvCn1KKJRQ@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAOq732Japcdcb2Y-j4KgtDV1Vb2ciwW2AEJCRCzzfvCn1KKJRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

> Since this tests things that are fixed by switching to l_netconfig,
> the test doesn't need any changes but src/netconfig.c does (that's

Shouldn't we fix the current netconfig implementation?  And then apply this test?

> what patch 13 does), but it's safe to hold on with this.

It might take us a bit of time until the switch to l_netconfig happens.  So 
fixing these small issues might be a good idea in the interim.

Regards,
-Denis
