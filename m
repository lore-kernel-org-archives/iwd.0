Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B164A47
	for <iwd@lists.linux.dev>; Thu,  6 Jul 2023 04:36:19 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-783549ef058so7156139f.2
        for <iwd@lists.linux.dev>; Wed, 05 Jul 2023 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688618179; x=1691210179;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nS2gODoDbW1NJ9Ft2S1WPvqoYeZn0OC50wsdBJEJm0s=;
        b=MNvytRrksfTPiWe2/CSexVExXVTSebiqKdtOZpXMWHGpI/4d8Xw8i/SUTbqPfkmV2/
         ToXsoEbIe2XlOV16Huct1jjmCQ31JBnx6JBgRg7zvn0y/2qtyDJEpToACPiq3uepaCTj
         EMcxV/TX5AUkhDu3/KGk4xtUvOly8KXkplRF9edz9W9nHZRWJc0B77PyM9rbbhiXzwom
         begfh+U2qDpNBPRttr26lh6UWGn+GSneOXV1KVd28/hZZ+z9WiKPchoxBDtCgotunzlL
         FZYSPNfep/VyUbDgRjb/vgQuR+eh47Lgqf+inYp5/3DVPezvAHbpeSvr2vhvL94ciqQB
         TbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688618179; x=1691210179;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nS2gODoDbW1NJ9Ft2S1WPvqoYeZn0OC50wsdBJEJm0s=;
        b=Ip3Xa1MBq1QEydhhsPcb7UAW/EE9snL0NNkev9mQwwyV9XlInmhdr9bvxjQPOLO2kU
         19DDZc0RGYk5aCtwgrfc3+iA/hakbw5sMhl/iobvsBwLrpSNfLsvQYJMCeV041d79Pub
         JFyJG22LzmTJx+x92E0GTonC6St1niBPy3FWR9Eba/Rto5Ej/U3QyUl4O2U9dxlCqEMB
         UjM+pgGQRIYHxPk3MgckDPhC7AJ8Qh/aJCHU5DTW6WbTQbtGVq4WNmYCT8l8wxEpQJCp
         3efvOzbyKsiEG2+QIJkYUfgg7Tu2hyd3DlKF3OTx9NSGoTyORvZ6FbFjMeTWSAN4d3XG
         euZg==
X-Gm-Message-State: ABy/qLZPh0R5H+kEpOD9hm/TdUwYOSfSbYCem/4uQgM5maznms5/e89X
	uI8eq3Ygz9e4k/EE1wbJDLA=
X-Google-Smtp-Source: APBJJlEoliGY6vSng8ndkPPQDk5ROJADlb0nWBI6h8OKSvMP1kdf45CJkvdi0KeGs//3I0TlrimyAw==
X-Received: by 2002:a5e:db49:0:b0:783:63d6:4cb with SMTP id r9-20020a5edb49000000b0078363d604cbmr1053955iop.14.1688618178991;
        Wed, 05 Jul 2023 21:36:18 -0700 (PDT)
Received: from [10.0.2.15] ([136.32.1.70])
        by smtp.googlemail.com with ESMTPSA id c1-20020a5ea901000000b0078680780694sm193900iod.34.2023.07.05.21.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 21:36:18 -0700 (PDT)
Message-ID: <12fbf71d-976d-fe2a-7326-547dab44b84a@gmail.com>
Date: Wed, 5 Jul 2023 23:36:17 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 0/5] Initial refactor for hwsim frame processing
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230630191812.2884637-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230630191812.2884637-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/30/23 14:18, James Prestwood wrote:
> I wanted to put this out there just as an idea before I get too
> invested in extending it. The code itself needs cleanup (explained
> later) but I wanted some feedback on the general idea.

No real objection, but if you're moving 1kloc of code around, make sure that any 
moves are separated from overall refinements and other changes.  For example, if 
you're exporting API functions or structures for use in (newly created) modules, 
do that first.

> 
> Eventually I'd like to extend this to support remote communication
> with multiple hwsim instances, e.g. via a multicast socket. As a
> starting point the rules code fit nicely as a frame processing
> module.

I assume you saw https://github.com/Raizo62/vwifi ?

> 
> Cleanup:
>   - Find solution for the IWD_MODULE_DEPENDS issue

Well, you need to put something into the section if you don't invoke 
IWD_MODULE_DEPENDS at least once.

>   - Add getters for radio/interface info objects, possibly
>     for hwsim_frame too rather than everything exposed in
>     hwsim.h.

That would be preferable.

>   - The hwsim_frame cleanup in rules needs to be changed. Prior
>     hwsim_frame_unref() would send tx_info but now this needs
>     to be handled in rules.c. Currently we peek into the refcount
>     and see if it will be destroyed on unref, and send tx_info
>     then.

Hmm, not sure I follow yet?

Also, iwd/tools/* is for executables that get built from single files.  I guess 
we could relax that, but it may be better to have hwsim live in its own 
directory, similar to ead & iwmon.

Regards,
-Denis
