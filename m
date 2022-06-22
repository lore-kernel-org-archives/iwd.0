Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C96111B
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 21:02:11 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id i25so22761325oii.7
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oifZpFT813Jx2qDh6ppQo1xkdKk2gW+w5c/U51FpjR8=;
        b=OhkJUKS+5XhpbgwbeYc9MXsxh7BQPCpyOUrgk8QTtgjDMSdVPlbe8pQrocZCS5DkX2
         X+vkC4rGy6PHrBZ4HmVSpjqwK8b4WPmwUVAREzZVTDX3/lw4gzKW0cBJfGS4tJl8Bq+G
         UgVH/cVUK9YbHoXRg7KiHaeCwHR/8xJLMiRPn9o/pcHmOCc5TxsG+i881QJ/qcCVwWeC
         lL6W30lmZGc0/yK5jepBt92WZnQNK2VXLwVx0hLHmAILG3v+T2Ug7JnJIlyhOFDV/ed9
         HY3wEL1jNtb0UW8QTxexj63fdEoiQRuIH9Zh5/rAopcPKz5pHETozCSOlylX5Sjmwv6f
         laZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oifZpFT813Jx2qDh6ppQo1xkdKk2gW+w5c/U51FpjR8=;
        b=Eir7rciuH365mZ3nNqJc+DNNKdmNz9+Q42ECvG1qVeAyIGq2YU62fhfuooqeBWgPoE
         EVqO4ERO1Mw0Ie7UWPmRsqoHCqfrCMPE3LTGG70OlJYbqatuVczeKQLx9eEclV6zBfb5
         gaqhTneyS0iLMArZshDx6PRlu3iQMacVtswteNvRc6toho74CfDFq6qPgUg2saelmBMB
         ilXDDcMiRRNkz0zzlxYTBtprYk67zT8wqdtJgY/W1xrhMtFNQO0dVtr2hIQusPBAA+0p
         BDBc2XNdNXajEiYJ50yEpnOuVKiEsEs46fgqf1HchW+xSTZv33hClMjbaCUKioL2Qo8q
         CsRA==
X-Gm-Message-State: AJIora8UaG/ZdEMxEIBFoAfHhp48VBkZwcWgNcfnnhw+Jh1mI2OsqIV7
	ecDBxIm4ZvjfWinoDOdkVW+0i6xmfIGSEesL
X-Google-Smtp-Source: AGRyM1sbR6FM33Nv2xraYBNtKoj7aUjqVXodw9M0Dg5ccMrMTfaSL+x0AhZ4GVVsOr0nnEpB4ItTtg==
X-Received: by 2002:a05:6808:148b:b0:32f:6ef6:47eb with SMTP id e11-20020a056808148b00b0032f6ef647ebmr152770oiw.285.1655931730230;
        Wed, 22 Jun 2022 14:02:10 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p3-20020a4a8143000000b0035eb4e5a6cbsm12289437oog.33.2022.06.22.14.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:02:09 -0700 (PDT)
Message-ID: <51dc9302-29e1-134c-7358-65ebdaae4db9@gmail.com>
Date: Wed, 22 Jun 2022 15:59:21 -0500
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
To: Andrew Zaborowski <andrew.zaborowski@intel.com>,
 James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-14-andrew.zaborowski@intel.com>
 <a0ee1952ace452c971d98cc208bd9d9eac1a3e92.camel@gmail.com>
 <CAOq732KZuR=cqNnozGDdnR94AAgh-B2Hu0patzN3smL_oSf=rQ@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAOq732KZuR=cqNnozGDdnR94AAgh-B2Hu0patzN3smL_oSf=rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/21/22 16:17, Andrew Zaborowski wrote:
> On Tue, 21 Jun 2022 at 23:04, James Prestwood <prestwoj@gmail.com> wrote:
>> Does this happen to depend on patch 13/15? I applied all the other
>> autotest changes but this one fails to pass testNetconfig. The
>> assertRaises() call is what fails for me.
> 
> It does, sorry I didn't make this clear.  Both 14 and 15 depend on 13/15.
> 

Can this test be made applicable to the current netconfig implementation?  In 
other words, does it really need to depend on patch 13?  Same with 15?

Regards,
-Denis
