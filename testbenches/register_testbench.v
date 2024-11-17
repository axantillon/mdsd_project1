module register_testbench();

//Inputs
    reg clk;
    reg [7:0] replaceData;
    reg [3:0] replaceSel, A_sel, B_sel;

//Outputs
    wire [7:0] A;
    wire [7:0] B;

    // Instantiate the Register File
    register_file uut (
        .clk(clk),
        .replaceData(replaceData),
        .replaceSel(replaceSel),
        .A_sel(A_sel),
        .B_sel(B_sel),
        .A(A),
        .B(B)
    );


   // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle `clk` every 5 time units
    end

    //Test stimulus
    initial begin
        // Write data into register 0
        replaceData = 8'hAA;
        replaceSel = 4'b0000;
        #10;

        // Select register 0 for output A and B
        A_sel = 4'b0000;
        B_sel = 4'b0000;
        #10;
        $display("A = %b, B = %b", A, B);

        // Write data into register 1
        replaceData = 8'hBB;
        replaceSel = 4'b0001;
        #10;

        // Select register 1 for output A and register 0 for output B
        A_sel = 4'b0001;
        B_sel = 4'b0000;
        #10; 
        $display("A = %b, B = %b", A, B);

        // Write data into register 2
        replaceData = 8'hCC;
        replaceSel = 4'b0010;
        #10;

        // Select register 2 for output A and register 1 for output B
        A_sel = 4'b0010;
        B_sel = 4'b0001;
        #10;
        $display("A = %b, B = %b", A, B);

        // Write data into register 3
        replaceData = 8'hDD;
        replaceSel = 4'b1111;
        #10;

        // Select register 3 for output A and register 1 for output B
        A_sel = 4'b1111;
        B_sel = 4'b0010;
        #10;
        $display("A = %b, B = %b", A, B);

        // Write data into register 4
        replaceData = 8'hEE;
        replaceSel = 4'b1010;
        #10;

        // Select register 4 for output A and register 1 for output B
        A_sel = 4'b1010;
        B_sel = 4'b1111;
        #10;
        $display("A = %b, B = %b", A, B);

        $finish;
    end

    initial begin
		// $monitor("t=%3d clk=%b replaceSel=%b A_sel=%b B_sel=%b replaceData=%b A=%b B=%b", $time, clk, replaceSel, A_sel, B_sel, replaceData, A, B);
		// $dumpfile("registertstb.vcd");
	end

endmodule