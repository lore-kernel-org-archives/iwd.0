Content-Type: multipart/mixed; boundary="===============0417521736298024069=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH v2 2/2] auto-t: add test for stopping periodic roam retries
Date: Fri, 29 Jan 2021 12:09:06 +0000
Message-ID: <7aa701d7-3d44-37c1-32f6-279c08209cfa@bang-olufsen.dk>
In-Reply-To: <4833e6d981e8b0af64b654017e2ed4f225748a1c.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0417521736298024069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/28/21 9:05 PM, James Prestwood wrote:
> Hi Alvin,
> =

> On Thu, 2021-01-28 at 13:24 +0000, Alvin =C5=A0ipraga wrote:
>> ---
>>   autotests/testRoamRetry/stop_retry_test.py | 134
>> +++++++++++++++++++++
>>   1 file changed, 134 insertions(+)
>>   create mode 100644 autotests/testRoamRetry/stop_retry_test.py
>>
>> diff --git a/autotests/testRoamRetry/stop_retry_test.py
>> b/autotests/testRoamRetry/stop_retry_test.py
>> new file mode 100644
>> index 00000000..bbe6e2a1
>> --- /dev/null
>> +++ b/autotests/testRoamRetry/stop_retry_test.py
>> @@ -0,0 +1,134 @@
>> +#!/usr/bin/python3
>> +
>> +import unittest
>> +import sys
>> +
>> +sys.path.append('../util')
>> +import iwd
>> +from iwd import IWD
>> +from iwd import PSKAgent
>> +from iwd import NetworkType
>> +
>> +import testutil
>> +
>> +from hostapd import HostapdCLI
>> +from hwsim import Hwsim
>> +
>> +class Test(unittest.TestCase):
>> +    # Test that we do not periodically retry roaming if the
>> transision looks
>> +    # like this: LOW [roam] [new bss] HIGH.
>> +    def test_stop_retry(self):
>> +        hwsim =3D Hwsim()
>> +
>> +        bss_hostapd =3D [ HostapdCLI(config=3D'ssid1.conf'),
>> +                        HostapdCLI(config=3D'ssid2.conf') ]
>> +        bss_radio =3D  [ hwsim.get_radio('rad0'),
>> +                       hwsim.get_radio('rad1') ]
>> +
>> +        rule0 =3D hwsim.rules.create()
>> +        rule0.source =3D bss_radio[0].addresses[0]
>> +        rule0.bidirectional =3D True
>> +
>> +        rule1 =3D hwsim.rules.create()
>> +        rule1.source =3D bss_radio[1].addresses[0]
>> +        rule1.bidirectional =3D True
>> +
>> +        # Fill in the neighbor AP tables in both BSSes.  By default
>> each
>> +        # instance knows only about current BSS, even inside one
>> hostapd
>> +        # process.
>> +        # Roaming still works without the neighbor AP table but
>> neighbor
>> +        # reports have to be disabled in the .conf files
>> +        bss0_nr =3D ''.join(bss_radio[0].addresses[0].split(':')) + \
>> +                '8f0000005101060603000000'
>> +        bss1_nr =3D ''.join(bss_radio[1].addresses[0].split(':')) + \
>> +                '8f0000005102060603000000'
>> +
>> +        bss_hostapd[0].set_neighbor(bss_radio[1].addresses[0],
>> 'TestRoamRetry',
>> +                bss1_nr)
>> +        bss_hostapd[1].set_neighbor(bss_radio[0].addresses[0],
>> 'TestRoamRetry',
>> +                bss0_nr)
>> +
>> +        # Start in the vicinity of BSS 0, check that iwd connects to
>> BSS 0
>> +        rule0.signal =3D -2000
>> +        rule1.signal =3D -5000
>> +
>> +        wd =3D IWD()
>> +
>> +        psk_agent =3D PSKAgent("secret123")
>> +        wd.register_psk_agent(psk_agent)
>> +
>> +        devices =3D wd.list_devices(1)
>> +        device =3D devices[0]
>> +
>> +        condition =3D 'not obj.scanning'
>> +        wd.wait_for_object_condition(device, condition)
>> +
>> +        device.scan()
>> +
>> +        condition =3D 'not obj.scanning'
>> +        wd.wait_for_object_condition(device, condition)
>> +
>> +        ordered_network =3D
>> device.get_ordered_network('TestRoamRetry')
>> +
>> +        self.assertEqual(ordered_network.type, NetworkType.psk)
>> +
>> +        condition =3D 'not obj.connected'
>> +        wd.wait_for_object_condition(ordered_network.network_object,
>> condition)
>> +
>> +        ordered_network.network_object.connect()
>> +
>> +        condition =3D 'obj.state =3D=3D DeviceState.connected'
>> +        wd.wait_for_object_condition(device, condition)
>> +
>> +        self.assertTrue(bss_hostapd[0].list_sta())
>> +        self.assertFalse(bss_hostapd[1].list_sta())
>> +
>> +        wd.wait(5)
> =

> Generally we try and avoid waits/sleeps at all costs because its very
> unreliable. For example test-runner is used by some people inside a VM
> (which then nests another VM) and this can be extremely slow. This
> causes all kinds of weird behavior when a test relies on a sleep or
> wait. Sometimes waits are necissary but in this case I don't think it
> is.
> =

> Instead it looks like this wait could be removed completely, then also
> remove max_wait=3D10 below. This is, again, not something we generally
> set explicitly for reasons mentioned above. Your fast system may start
> roaming in 10 seconds, but a slow VM may take longer.
> =

>> +
>> +        # Now push the signal below the RSSI threshold and check
>> that iwd
>> +        # connects to BSS 1
>> +        rule0.signal =3D -8000
>> +
>> +        condition =3D 'obj.state =3D=3D DeviceState.roaming'
>> +        wd.wait_for_object_condition(device, condition, max_wait=3D10)
> =

> I would just remove max_wait here.
> =

>> +
>> +        # Check that iwd is on BSS 1 once out of roaming state and
>> doesn't
>> +        # go through 'disconnected', 'autoconnect', 'connecting' in
>> between
>> +        condition =3D 'obj.state !=3D DeviceState.roaming'
>> +        wd.wait_for_object_condition(device, condition, max_wait=3D5)
> =

> And here.
> =

>> +
>> +        self.assertEqual(device.state, iwd.DeviceState.connected)
>> +        self.assertTrue(bss_hostapd[1].list_sta())
>> +
>> +        wd.wait(5)
> =

> I also would remove this wait.
> =

>> +
>> +        # Now make sure that we don't roam anymore. In order to
>> catch this via
>> +        # DeviceState, a suitable roaming target needs to be
>> available. So jack
>> +        # up the RSSI of BSS 0 again. The retry interval is 60
>> seconds, so we
>> +        # should have roamed within that timeframe.
>> +        rule0.signal =3D -2000
>> +
>> +        condition =3D 'obj.state =3D=3D DeviceState.roaming'
>> +        self.assertRaises(TimeoutError,
>> wd.wait_for_object_condition, device,
>> +                          condition, max_wait=3D60)
>> +
>> +        device.disconnect()
>> +
>> +        condition =3D 'not obj.connected'
>> +        wd.wait_for_object_condition(ordered_network.network_object,
>> condition)
>> +
>> +        wd.unregister_psk_agent(psk_agent)
>> +
>> +        rule0.remove()
>> +        rule1.remove()
>> +
>> +    @classmethod
>> +    def setUpClass(cls):
>> +        pass
>> +
>> +    @classmethod
>> +    def tearDownClass(cls):
>> +        IWD.clear_storage()
>> +
>> +if __name__ =3D=3D '__main__':
>> +    unittest.main(exit=3DTrue)
> =

> Thanks again for your patches! Sorry if its frustrating that our test
> framework has what seem like 'rules' which are undocumented and not
> intuative. These type of things have been added over time for certain
> cases and not much care was taken to prevent them from being used
> generally. Besides these minor things the tests look great.

No problem at all. I reworked the test and removed all but the last =

max_wait condition, so please take a look at v3. Note that I increased =

the max_wait for the final check from 60 to 70 seconds on account of the =

slowness of the test environment. Hope that's OK!

Kind regards,
Alvin
--===============0417521736298024069==--

