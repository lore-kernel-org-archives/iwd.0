Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0E15B7
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 13:51:23 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-643990c5319so3020037b3a.2
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683553883; x=1686145883;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aLjQ2yztiV85rzBB0iPtpB6AZzSV1yfvrEA+VuviXg=;
        b=DDgsrRK79NHMy/AMmAGl/Uaj4mLAuRmGrjixXNuXlHYmesbjNyrJmzXhhaCVW2Wtfc
         xYAa11f5QebvVOIMouwQ4xBdVKOHwTulIEem9i7rZmawv8auOwH78vXdevwiGV00OZJ+
         +J7X2/uw4/JUE1avDKPrzmw2sDo+2N+XUV8b6goig0t9z+/jsP4Fr3Ob0Gn0f9Yhn+EE
         jm65b5nLPnnMetcbeQBsL6WgJ9pquWgk8tlAOrucEA4Xx73NtF103bqRGhtIEqRtB2xE
         /xTf766gDgz5MvbbFeOvkPMImAKIgfP/qQoKuefFR1hFtIDXoPDh33Znc+VeKeFehTPd
         IUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683553883; x=1686145883;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aLjQ2yztiV85rzBB0iPtpB6AZzSV1yfvrEA+VuviXg=;
        b=WyLW1F92lOglCJ6Wi7VSXANEFDL2BJY5wUc9k0SHTbCC/CQ9TR9fJ+eJZrqB8qzMKT
         4d+MSc2Kme+z6ZVews9t1xfXj3w2kAa4UPqFRh4QQPsZOoNwLGh19StkdX0P6qXfpFAo
         gbXYZdN/mtvXoclmfIC4xS4oAzcO1djMh2owxXZdscCais+r8N8U+sxjFxwC16zMISPN
         ChtrC0q6+zx83pFoY9AUC0rrHtvaS+t6U9RIZ9c8PUixxCpWMSuefpFTFl+Qlzb8Kz46
         g1iXsbAd5wNy9wd9Ru5mQMPtNc1t8PyukSBMOXptULtQQ5YHhSbcwhltd+tAAGyy9qfa
         3VZg==
X-Gm-Message-State: AC+VfDwk1VZfjO8EtATm3+bSVSkDFFWOW/NMa3pvSDm5AgBJCFs+XSm1
	kLhm6a0uPF8aM3S/4Zd9pr9Za9nubA+UQw==
X-Google-Smtp-Source: ACHHUZ4YBKPpstJtkjKmodlWX0kxVvbS8t1ut1ZAFjFMeQ20ihjJegU1rNNtpkBJ5IaH0Vtl3qgZvQ==
X-Received: by 2002:a05:6a00:23d3:b0:63d:4752:4da3 with SMTP id g19-20020a056a0023d300b0063d47524da3mr13325875pfc.25.1683553882982;
        Mon, 08 May 2023 06:51:22 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s26-20020a62e71a000000b0064358d032a4sm6353492pfh.145.2023.05.08.06.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:51:22 -0700 (PDT)
Message-ID: <ede25165-0224-3b47-2dea-5dca29443a36@gmail.com>
Date: Mon, 8 May 2023 06:51:19 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] station: allow roaming before netconfig finishes
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230502185941.436015-1-prestwoj@gmail.com>
 <1f99600d-a154-e757-17bf-18078b0f3d71@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1f99600d-a154-e757-17bf-18078b0f3d71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 5/7/23 4:06 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 5/2/23 13:59, James Prestwood wrote:
>> If IWD connects under bad RF conditions and netconfig takes
>> a while to complete (e.g. slow DHCP), the roam timeout
>> could fire before DHCP is done. Then, after the roam,
>> IWD would transition automatically to connected before
>> DHCP was finished. In theory DHCP could still complete after
>> this point but any process depending on IWD's connected
>> state would be uninformed and assume IP networking is up.
>>
>> Fix this by stopping netconfig prior to a roam if IWD is not
>> in a connected state. Then, once the roam either failed or
>> succeeded, start netconfig again.
>> ---
>>   src/station.c | 151 ++++++++++++++++++++++++++++++--------------------
>>   1 file changed, 90 insertions(+), 61 deletions(-)
>>
>> v2:
>>   * Reworked to allow the roam to finish then start netconfig.
>>     Now netconfig will be reset and resumed after the roam.
>>
> 
> I went ahead and applied this.  But the question still remains whether 
> this was tested somehow?  Is there an auto test for this maybe?

I tested this locally, my DHCP server seems really screwed up and takes 
forever (in this case perfect for testing). But adding an autotest was 
planned as well (which will need those hwsim/namespace changes)

> 
> Regards,
> -Denis
> 
