Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5EA8466;
	Tue,  3 Jan 2023 15:25:16 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-142b72a728fso37062113fac.9;
        Tue, 03 Jan 2023 07:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8lkxVki/W7gC22aErQEdTwKRDG9eA5n9qZIHlsFV14=;
        b=VsbgwHQh8dm///cvj7H/41i+YUUZLkwZ1Ywap5AOvVw5cRNe7I20SKxy0llaZjwRGx
         Gz5gVauyRomsOlcvMCoNllg8HerQMVRJ5LZnkC5pXHXceoCFpHlbiqGWeu/fB6yhRRgw
         D7/rtCxOMaJrZIdNWefwhx4SU16N67y6sRkBII+AFok0w5Y7rtl4pk19Ty+65gNNza2d
         wvcw6CkhhTk+Vd5EQx7AeVuJpNBdTHVndKIKBAwajUMkNwSvELHO86Z3AuVydh6F3z4T
         lk+SJcNn/1T6WVMjbX2KvlljJWdXmF73RKm3Edrssth5Husw3/nUncX7XJ961yen2ePn
         +Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8lkxVki/W7gC22aErQEdTwKRDG9eA5n9qZIHlsFV14=;
        b=xwdkgtRTbcK/Aq2MzVyYuuiYsz3pLLxnd+8U2zWUBgUDYcN6cdUDMc13VklEIM0AtI
         2usILKLBDxyRuWQl3cAySpzlUFfnI5+Ta/GYFs8Q+3KdfBrNXBWdB+HxrPikuE9P210U
         VcTZ7/cOwz2W9bdfzx6p96Ms0LfnLimTB6NiIjUHZUOz2VRhxriATQkKG+VM+boRRnaF
         IB5ZMEvGekiA6xFB8yZkQhq189j2lMM7BaX8EgWhbaS6lYaYro2v5faFp6E5AK4fCnyt
         HIjU3UQfRSKiq1hy+Dc4RXd9eIxFlHJXK6PiBC0J2BwozgjmjGTv2F1acrmKsAsjWcQI
         BYMw==
X-Gm-Message-State: AFqh2kqcGeL+tHzbRSaS2RiAgQ0qNTFNaqvyXRwnfI1Sy78JOVU+/BlH
	1A/bnryv/Tv4qBUWiY/gSMgeHGlFPxE=
X-Google-Smtp-Source: AMrXdXtKEzs2fAQEXvvgG9MHaF8fGEwkTxDthP1e4Up4nock+uGZVKuMGebeQFjE4DcFgNjYH5880A==
X-Received: by 2002:a05:6870:4511:b0:150:bb6c:2798 with SMTP id e17-20020a056870451100b00150bb6c2798mr2763100oao.31.1672759515955;
        Tue, 03 Jan 2023 07:25:15 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y25-20020a056870b01900b00144a3c526d9sm14385649oae.52.2023.01.03.07.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 07:25:15 -0800 (PST)
Message-ID: <cbf0c602-a854-bc24-a7ae-0eec05be86ec@gmail.com>
Date: Tue, 3 Jan 2023 09:20:46 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: bug: 802.1x configuration is not turned into an iwd KnownNetwork
Content-Language: en-US
To: Daniel Wagner <wagi@monom.org>, Jade Lovelace <lists@jade.fyi>
Cc: connman@lists.linux.dev, iwd@lists.linux.dev
References: <CAFA9we_ArzwtDidQkEQTL-vEPC2GGnRTqZB7jbx=UZ-R1MkzoA@mail.gmail.com>
 <20230102082941.rhlb4dfwzhkvmav7@beryllium.lan>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230102082941.rhlb4dfwzhkvmav7@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

> ConnMan interacts with iwd only via the D-Bus interface. I can't remember that
> we added any code to do any provisioning in iwd (also a quick glance over the
> iwd plugin code doesn't ring any bell). Also I couldn't find any API doc in iwd
> which covers this topic. So I don't know if it is currently possible to
> provision iwd via the D-Bus API.

There's no way to provision 802.1x networks over D-Bus.  However, connman can 
write provisioning files to iwd's storage dir (/var/lib/iwd typically) and iwd 
will pick these up.  This is what the NM backend does.

Regards,
-Denis
