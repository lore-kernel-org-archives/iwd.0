Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882142F43
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 21:15:39 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id x25-20020a056830115900b00670932eff32so10528172otq.3
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=floadjjL2GoxaCmDxkAoej+SDpCdlRLvHLRct4Lyi3M=;
        b=OOfSQt5pAzhCCYV3nnfKtDs+qGoCjviaNc+fA9k4YeKdpO0UZS8R2oXu+VXKmP9EgM
         SzoUZhwxCglJLkTSN0piyQ2eLcDy6reHCFW2RO/wwBlXOdl+sl1Cqqoc+NMxLQpVvYSC
         sWlsRpE+7uFi0pxKRe4ysno1gObOIOasXfgwW4Tj/C1SjzaBl5WWDaZ/BrJWJTFXR34B
         d8EECw0SLjhqLGuuiqwV3zwPerwLvQvxrP1Y2KUaWQzKHCz24fMDzwK4MBUNh2npsXw3
         4br0lpsz8rE/1EzRZRbq1deRz5DkPTHyXmvgEyRocY/614tkvEz8aloEwVcgTYBE82RD
         1koA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=floadjjL2GoxaCmDxkAoej+SDpCdlRLvHLRct4Lyi3M=;
        b=Z/gSPLlNLhiybkAKuXSK6U2RGpe8j6iqOTWC7/5WJUfv+CqxWURwAK20YLpID3DYRw
         gj7/DFMJz21sPaQ1kwl4GU2XG9R5dz8ei3QrnEqLuHQVEW9F1lxkvKbJqtQkj5cPivZS
         6SRWDgG/VRFnRZOxu0LZrwUawVGIHmz2iI1a0uNwVB2TiGzLbtw+I1F4ojx5qE3JN4dQ
         tCDXmEDs9d0rBk4whMfr8F6efvbhrRdTehqi/1P8Ss8hvVWSCY+fOikOvq01VIrlYH6D
         ERLB/vdvPqg/WGcAUyBS0NAXsyUeHu/SYN3dQohLmfd8jvwerfQcPN/53F51VdfKVx5W
         ua0w==
X-Gm-Message-State: AFqh2kqYS7BCUXGkUEwvxOLPjY4z3CjF3qPScxCNEHiJfzZ9wCoXpWug
	cIujoF894/ylUy5wTA0wqaA=
X-Google-Smtp-Source: AMrXdXs/2aBcLwlmKsl/Gy62TTJjb/v0zIc/qBN/eOvXp57NXq2bo6momXoHX9MDo2bXf3hQOqNU1w==
X-Received: by 2002:a9d:6e12:0:b0:678:2f17:77b3 with SMTP id e18-20020a9d6e12000000b006782f1777b3mr13182052otr.38.1672262138566;
        Wed, 28 Dec 2022 13:15:38 -0800 (PST)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id y7-20020a0568301d8700b00684074fbce6sm508606oti.54.2022.12.28.13.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 13:15:37 -0800 (PST)
Message-ID: <c1ace2ab-2ffe-ab37-cd33-0f9f0d6c2807@gmail.com>
Date: Wed, 28 Dec 2022 15:10:05 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/10] band: add APIs to generate a chandef from frequency
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221220214318.2041986-1-prestwoj@gmail.com>
 <20221220214318.2041986-5-prestwoj@gmail.com>
 <f1d0679d-a6df-f274-5c95-909a9a3ed383@gmail.com>
 <ca84d3ce71bf2f17360f63303bbca1b841eb36cc.camel@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ca84d3ce71bf2f17360f63303bbca1b841eb36cc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> We still need to support 20Mhz since there is this distinction between
> 20MHz HT and 20Mhz no-HT. If only 20MHz HT is supported we should pick
> that rather than the non-HT width.

Hmm, but there's no difference in operating class between 20HT and 20NoHT.  So 
this could be done post-factum, no?

> 
> So ap.c just tries to pick the best chandef so in theory we could fall
> back to non-HT and this wouldn't be totally unexpected (from the users
> perspective). The problem is we would then need to disable HT in ap.c
> if we fell back to non-HT.

Something like if ap->chandef.channel_width == 20HT && !ap->supports_ht -> set 
channel_width appropriately.

> 
> Since I may just remove band_freq_to_chandef() entirely I might instead
> keep the -ENOENT return and fall back inside ap.c itself. Then I don't
> have to check chandef->channel_width after a successful return and we
> know this will always return an HT chandef, or fail.
> 

Or do that.  Or pass in the ht capability to band_freq_to_chandef() and let it 
figure it out.

Regards,
-Denis
